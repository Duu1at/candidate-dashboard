# Patterns reference

The recurring building blocks of Flutter take-homes. Adapt names to the spec.

## Freezed models

One model per entity. Keep them pure data — no business logic. Use enums for closed sets (status, verdict).

```dart
@freezed
class Candidate with _$Candidate {
  const factory Candidate({
    required String id,
    required String name,
    required String city,
    @JsonKey(name: 'total_exp') required String totalExp,
    required Verdict verdict,
    required String stack,
    @Default(ProcessingStatus.newCandidate) ProcessingStatus status,
    @Default([]) List<Criterion> criteria,
    @Default([]) List<String> questions,
  }) = _Candidate;

  factory Candidate.fromJson(Map<String, dynamic> json) =>
      _$CandidateFromJson(json);
}

enum Verdict {
  @JsonValue('verdict-green') suitable,
  @JsonValue('verdict-orange') partial,
  @JsonValue('verdict-red') notSuitable,
}
```

For odd JSON shapes (e.g. experience as a list of string arrays), parse in a small custom converter rather than leaking `dynamic` into the model. After editing, run `dart run build_runner build --delete-conflicting-outputs` and confirm the provided mock parses end-to-end.

## Mock dio interceptor (swappable for a real API)

The reviewer's key check: data loads through `dio` so the mock can later be replaced by a real endpoint with no call-site changes. Intercept requests, add realistic latency, return the asset JSON.

```dart
class MockInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    await Future.delayed(
        Duration(milliseconds: 300 + Random().nextInt(500))); // 300–800ms

    if (options.path == '/candidates' && options.method == 'GET') {
      final raw = await rootBundle.loadString('mock/candidates.json');
      return handler.resolve(Response(
        requestOptions: options,
        statusCode: 200,
        data: jsonDecode(raw),
      ));
    }

    if (options.path.startsWith('/candidates/') &&
        options.method == 'PATCH') {
      if (Random().nextDouble() < 0.10) {            // ~10% simulated failure
        return handler.reject(DioException(
          requestOptions: options,
          response: Response(requestOptions: options, statusCode: 500),
        ));
      }
      return handler.resolve(
          Response(requestOptions: options, statusCode: 200));
    }

    handler.next(options);
  }
}
```

The remote data source just calls `dio.get('/candidates')` — it doesn't know it's a mock. Swapping in a real `baseUrl` and removing the interceptor is the only change needed later.

## Debounced search + client-side filter/sort

Debounce keeps a 300ms search from rebuilding/refetching on every keystroke.

```dart
class Debouncer {
  Debouncer(this.delay);
  final Duration delay;
  Timer? _timer;
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
  void dispose() => _timer?.cancel();
}
```

Keep filter/sort as pure functions so they're unit-testable without UI:

```dart
List<Candidate> applyFilters(
  List<Candidate> all, {
  required String query,
  Verdict? verdict,
  required SortBy sort,
}) {
  var result = all.where((c) =>
      c.name.toLowerCase().contains(query.toLowerCase()) &&
      (verdict == null || c.verdict == verdict)).toList();
  switch (sort) {
    case SortBy.name: result.sort((a, b) => a.name.compareTo(b.name));
    case SortBy.experience: /* compare parsed experience */ break;
    case SortBy.dateAdded: /* keep source order */ break;
  }
  return result;
}
```

## Pagination / infinite scroll

Page the filtered list (e.g. 10 per page). Attach a `ScrollController`; when near the bottom and not already loading and more pages remain, emit the next page. Track `items`, `page`, `hasMore`, and `isLoadingMore` in the state. Use `ListView.builder` so only visible rows build.

## Optimistic update with rollback

Update the UI immediately, fire the mock PATCH, revert if it fails — and keep list and detail consistent (both read the repository as the single source of truth).

```dart
Future<void> changeStatus(String id, ProcessingStatus next) async {
  final previous = state.candidate;
  emit(state.copyWith(candidate: previous.copyWith(status: next))); // optimistic
  try {
    await repository.updateStatus(id, next);   // mock PATCH (~10% fails)
    // success: keep the optimistic value; show success snackbar
  } catch (_) {
    emit(state.copyWith(candidate: previous)); // rollback
    emit(state.copyWith(error: 'Could not update status')); // error snackbar
  }
}
```

Have the repository hold the canonical candidate list and expose a stream or notify both cubits, so the list badge and the detail screen never disagree.

## Offline cache + persisted status

Cache through the repository. On load: try remote; on network failure fall back to the Hive cache and surface an offline flag. On a successful fetch, write the cache.

```dart
Future<List<Candidate>> getCandidates({bool forceRefresh = false}) async {
  try {
    final remote = await remoteDataSource.fetch();
    await localDataSource.cacheCandidates(remote); // refresh cache
    return remote;
  } on DioException {
    final cached = await localDataSource.getCached();
    if (cached.isEmpty) rethrow;
    _isOffline = true;                              // drives the offline banner
    return cached;
  }
}
```

Persist status changes locally so they survive a restart — write the new status to the Hive box on change, and merge persisted statuses over freshly fetched data when reloading. Add pull-to-refresh (`RefreshIndicator`) for the online refresh path.

### Optional: sync queue

For the "strong middle" bonus: when a status change can't reach the server (offline), enqueue it in a persisted queue (Hive box of pending ops). On connectivity regained (`connectivity_plus`), drain the queue, replay the PATCHes, and clear succeeded entries. Mention conflict handling (last-write-wins is fine, just state it) in the README.

## Clickable contacts

Use `url_launcher` with the right schemes: `tel:` for phone, `mailto:` for email, the Telegram URL for `tg`. Guard each with `canLaunchUrl` and show a snackbar if it can't be opened.