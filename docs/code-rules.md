# Code Rules

Code conventions and standards for the Candidate Dashboard project.

## General

- **Linter:** `flutter_lints` (via `package:flutter_lints/flutter.yaml`)
- **Formatter:** `dart format .` (default 80-char line length)
- **Trailing commas:** required (`require_trailing_commas: true`)

### `analysis_options.yaml`

```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  errors:
    avoid_print: warning
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
    - "lib/core/di/injection.config.dart"

linter:
  rules:
    prefer_const_constructors: true
    require_trailing_commas: true
    prefer_final_fields: true
```

---

## Naming

### Files

- Format: `snake_case.dart`
- Examples: `candidates_list_cubit.dart`, `candidate_card.dart`, `remote_datasource_impl.dart`

### Classes

| Type | Format | Example |
| --- | --- | --- |
| Interface | `abstract class` or `abstract interface class` | `CandidateRepository`, `RemoteDatasource` |
| Implementation | `Impl` suffix | `CandidateRepositoryImpl`, `RemoteDatasourceImpl` |
| Model (freezed) | plain name | `Candidate` |
| Enum | plain name | `CandidateStatus`, `SortOption` |
| Cubit | `Cubit` suffix | `CandidatesListCubit`, `CandidateDetailCubit` |
| State | `State` suffix | `CandidatesListState`, `CandidateDetailState` |
| Repository | `Repository` suffix | `CandidateRepository` |
| DI module | `Module` suffix | `RegisterModule` |

> **Don't add `I` prefix to interfaces.** The `Impl` suffix on the
> implementation already conveys the interface/impl relationship.

### Class keywords

```dart
// Interfaces
abstract class CandidateRepository { ... }
abstract interface class RemoteDatasource { ... }

// Freezed models
@freezed
abstract class Candidate with _$Candidate { ... }

// Freezed state
@freezed
abstract class CandidatesListState with _$CandidatesListState { ... }

// Injectable implementation
@LazySingleton(as: CandidateRepository)
class CandidateRepositoryImpl implements CandidateRepository { ... }
```

### Variables and methods

- `camelCase` — `allCandidates`, `verdictFilter`
- Private members use `_` prefix: `_remote`, `_cache`, `_controller`
- Constants use `camelCase`, not `SCREAMING_SNAKE`: `static const x4 = 16`
- Methods use `camelCase`: `loadNextPage()`, `filterByVerdict()`

### Constructor parameter style

If a class has **exactly one** domain parameter, use a **positional**
parameter — not a single-element named bag.

```dart
// Bad — noisy named API for one field
const SkeletonCard({required this.width, super.key});

// Good — positional reads naturally at the call site
const SkeletonCard(this.width, {super.key});
```

`super.key` doesn't count toward the "one parameter" tally — it's a
framework concern. Multi-domain-param widgets stay named
(`{required this.candidate, required this.onTap}`) so call sites self-document.

### Trailing commas & multi-line formatting

`require_trailing_commas: true` is enforced. Use it as a formatting lever:

- **Single arg** → keep it on one line.
- **2+ args** → put each on its own line **with a trailing comma**.

```dart
// Bad — next add/edit thrashes the whole line
Icon(Icons.check_circle_outline_rounded, color: context.appColors.verdictGreen.dot),

// Good — each arg owns a line, trailing comma keeps shape stable
Icon(
  Icons.check_circle_outline_rounded,
  color: context.appColors.verdictGreen.dot,
),
```

---

## Import order

```dart
// 1. Dart SDK
import 'dart:async';
import 'dart:convert';

// 2. Flutter SDK
import 'package:flutter/material.dart';

// 3. External packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// 4. Internal package (core barrel)
import 'package:candidate_dashboard/core/core.dart';

// 5. Relative imports (within the same feature or layer)
import '../cubit/candidates_list_cubit.dart';
import '../widgets/candidate_card.dart';
```

Internal code uses relative imports. Only `core.dart` (the core barrel) is
imported as a package path. Never reach into sub-paths of another feature
directly — if you need something from another feature, it should be
accessible via that feature's barrel or moved to `core/`.

---

## Models

Use **Freezed** for all data models and state classes. Do not use `Equatable`
or manual `copyWith`.

```dart
@freezed
abstract class Candidate with _$Candidate {
  const factory Candidate({
    required String id,
    required String name,
    @Default('new') String status,
    @JsonKey(name: 'date_added') String? dateAdded,
  }) = _Candidate;

  factory Candidate.fromJson(Map<String, dynamic> json) =>
      _$CandidateFromJson(json);
}
```

- All fields `required` by default; use `@Default(...)` for optional fields with defaults
- JSON key renaming: `@JsonKey(name: 'snake_case_key')`
- Custom JSON converters: factory functions passed to `@JsonKey(fromJson:, toJson:)`
- Generated files (`*.freezed.dart`, `*.g.dart`) are excluded from analysis but **committed to git**

### Enum with serialization

```dart
enum CandidateStatus {
  newCandidate('new', 'Новый'),
  review('review', 'На рассмотрении');

  const CandidateStatus(this.value, this.label);
  final String value;
  final String label;

  static CandidateStatus fromValue(String value) =>
      CandidateStatus.values.firstWhere(
        (s) => s.value == value,
        orElse: () => CandidateStatus.newCandidate,
      );
}
```

---

## State management

### Cubit vs Bloc

- **Cubit** — preferred for all state in this project
- **Bloc** — only if event-based state machine logic is genuinely needed

### State shape — single state + freezed copyWith

All state classes use Freezed's `@freezed` with a status enum for loading
phases and nullable fields for transient data.

```dart
enum CandidatesListStatus { initial, loading, loaded, error }

@freezed
abstract class CandidatesListState with _$CandidatesListState {
  const factory CandidatesListState({
    @Default(CandidatesListStatus.initial) CandidatesListStatus status,
    @Default([]) List<Candidate> allCandidates,
    @Default([]) List<Candidate> filteredCandidates,
    @Default(false) bool isOffline,
    String? errorMessage,
  }) = _CandidatesListState;
}
```

Emit with `.copyWith(...)` — Freezed generates it automatically.

### Async operations

Emit loading, await, emit success or error:

```dart
Future<void> load({bool forceRefresh = false}) async {
  emit(state.copyWith(status: CandidatesListStatus.loading));
  try {
    final candidates = await _repository.getCandidates(forceRefresh: forceRefresh);
    emit(state.copyWith(
      status: CandidatesListStatus.loaded,
      allCandidates: candidates,
    ));
  } catch (e) {
    emit(state.copyWith(
      status: CandidatesListStatus.error,
      errorMessage: e.toString(),
    ));
  }
}
```

### Optimistic updates

For status updates: emit the change immediately, then call the API. On
failure, roll back and emit a brief error state before returning to `loaded`:

```dart
Future<void> updateStatus(String newStatus) async {
  final prev = state.candidate;
  if (prev == null) return;

  emit(state.copyWith(
    status: CandidateDetailStatus.updatingStatus,
    candidate: prev.copyWith(status: newStatus),
  ));

  try {
    await _repository.updateStatus(prev.id, newStatus);
    emit(state.copyWith(status: CandidateDetailStatus.loaded));
  } catch (_) {
    emit(state.copyWith(
      status: CandidateDetailStatus.error,
      candidate: prev,
      errorMessage: 'Ошибка обновления статуса. Попробуйте ещё раз.',
    ));
    await Future<void>.delayed(const Duration(milliseconds: 100));
    emit(state.copyWith(status: CandidateDetailStatus.loaded, errorMessage: null));
  }
}
```

---

## Repositories

### Layers

```
Cubit → Repository → RemoteDatasource / LocalDatasource
```

- **Repository**: owns business logic, orchestrates sources, holds in-memory
  cache and connectivity state. Declared as `abstract class` + `Impl`.
- **RemoteDatasource**: Dio calls. Declared as `abstract interface class` + `Impl`.
- **LocalDatasource**: Hive persistence. Declared as `abstract class` + `Impl`.

### Interface + Impl pattern

Both datasources and the repository are split into interface + implementation.
The interface is what cubits and tests depend on; the implementation is wired
by Injectable.

```dart
abstract class CandidateRepository {
  Future<List<Candidate>> getCandidates({bool forceRefresh = false});
  Future<void> updateStatus(String id, String status);
  Stream<List<Candidate>> get candidatesStream;
  bool get isOffline;
}

@LazySingleton(as: CandidateRepository)
class CandidateRepositoryImpl implements CandidateRepository {
  CandidateRepositoryImpl(this._remote, this._local);
  // ...
}
```

---

## Navigation

- Routes are `static const` on `AppRoutes`
- Navigate with GoRouter: `context.push()`, `context.go()`, `context.pop()`
- Path parameters: `context.push('/candidates/${candidate.id}')`

```dart
abstract final class AppRoutes {
  static const init = '/';
  static const candidatesList = '/candidates';
  static const candidateDetail = '/candidate/:id';  // nested → /candidates/candidate/:id
}
```

---

## DI (GetIt + Injectable)

Use `@injectable` annotations — never register manually in `GetIt`.

| Annotation | Scope | Use for |
| --- | --- | --- |
| `@lazySingleton` | Single instance, lazy | Services in `@module` (Dio, Hive boxes) |
| `@LazySingleton(as: Interface)` | Single instance, lazy | Repository / datasource implementations |
| `@injectable` | New instance per call | Cubits |
| `@Named('...')` | Named qualifier | Multiple registrations of the same type (e.g. two Hive boxes) |

After adding or changing annotations, regenerate:

```bash
dart run build_runner build --delete-conflicting-outputs
```

The generated `injection.config.dart` is committed and excluded from analysis.

### Cubit ownership

**App-level cubit** (shared across the whole app or multiple screens):
wrap the app root in `BlocProvider`:

```dart
// app.dart
BlocProvider(
  create: (_) => getIt<CandidatesListCubit>(),
  child: MaterialApp.router(...),
)
```

**Screen-level cubit** (owned by one route):
provide it at the route's builder so it's disposed when the route is popped:

```dart
GoRoute(
  path: AppRoutes.candidateDetail,
  builder: (context, state) => BlocProvider(
    create: (_) => getIt<CandidateDetailCubit>()..load(state.pathParameters['id']!),
    child: const CandidateDetailScreen(),
  ),
),
```

---

## Feature folder structure

Each feature lives under `lib/features/<feature>/` with three sub-folders:

```
features/<feature>/
├── cubit/
│   ├── <feature>_cubit.dart
│   └── <feature>_state.dart
├── view/
│   └── <feature>_screen.dart
└── widgets/            ← private to this feature
    ├── some_card.dart
    └── some_sheet.dart
```

A widget that's **truly cross-feature** belongs in `lib/core/` or a shared
`lib/ui/components/` directory — not under any one feature.

When a feature grows to multiple screens, each screen gets its own nested
folder with its own `cubit/`, `view/`, `widgets/` inside the feature root.
Don't dump all cubits in one flat `cubit/` when they belong to different
sub-screens.

---

## BlocBuilder rebuild scope

Wrap the **smallest** widget that depends on state, not the whole screen.
Use `buildWhen` to gate rebuilds on the specific slice that changed.

```dart
// Bad — whole AppBar actions rebuild on any state change
actions: [
  BlocBuilder<CandidatesListCubit, CandidatesListState>(
    builder: (context, state) => IconButton(...),
  ),
],

// Good — only rebuilds when sort or status changes
actions: [
  BlocBuilder<CandidatesListCubit, CandidatesListState>(
    buildWhen: (a, b) => a.sortBy != b.sortBy || a.status != b.status,
    builder: (context, state) => IconButton(...),
  ),
],
```

Use `BlocConsumer` when you need both `builder` (UI) and `listener` (side
effects like SnackBars):

```dart
BlocConsumer<CandidateDetailCubit, CandidateDetailState>(
  listenWhen: (a, b) => a.errorMessage != b.errorMessage && b.errorMessage != null,
  listener: (context, state) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(state.errorMessage!)),
    );
  },
  builder: (context, state) => ...,
)
```

### `Scaffold` / `ListView` belong **outside** the builder

A view's structural scaffolding doesn't depend on cubit state — only its
leaves do. Keep the structure stable and narrow each dynamic leaf into its
own `BlocBuilder`.

```dart
// Bad — Scaffold + CustomScrollView rebuild on every emit
body: BlocBuilder<MyCubit, MyState>(
  builder: (_, state) => CustomScrollView(slivers: [...]),
),

// Good — structure is static, builder only wraps the dynamic leaf
body: CustomScrollView(
  slivers: [
    SliverAppBar(...),
    SliverToBoxAdapter(
      child: BlocBuilder<MyCubit, MyState>(
        buildWhen: (a, b) => a.status != b.status,
        builder: (_, state) => _StatusSelector(state),
      ),
    ),
  ],
),
```

---

## Don't put complex logic inline in widget trees

`build()` should be **declarative** — read like a tree, not an algorithm.
If you find yourself computing flags or switching on enums inside a
`builder:` callback, move that work to:

- **A getter on the model** (`candidate.isRejected`)
- **A computed property on the state class** (`state.hasResults`)
- **A dedicated widget** that owns the conditional rendering

**Bad — multi-step logic inline:**

```dart
builder: (_, state) {
  final vc = state.candidate?.vc ?? '';
  final isGreen = vc == 'verdict-green';
  final isOrange = vc == 'verdict-orange';
  final color = isGreen ? Colors.green : isOrange ? Colors.orange : Colors.red;
  return Container(color: color, child: Text(state.candidate?.verdict ?? ''));
},
```

**Good — push logic into verdict_colors util, use a widget:**

```dart
builder: (_, state) {
  if (state.candidate == null) return const SizedBox.shrink();
  return _VerdictBadge(vc: state.candidate!.vc, verdict: state.candidate!.verdict);
},
```

**Rule of thumb:** if a `builder:` has more than one local variable or one
`if`, refactor.

---

## Widgets and UI

### Avoid `Container`

Prefer the lighter alternatives:

| Need | Use |
| --- | --- |
| Color only | `ColoredBox` |
| Size only | `SizedBox` |
| Decoration only | `DecoratedBox` |
| Padding only | `Padding` |
| Alignment only | `Align` |

```dart
// Bad
Container(height: 24, color: Colors.white)

// Good
SizedBox(height: 24, child: ColoredBox(color: context.colors.surface))
```

### Theme system

The theme is the single source of truth for colors, typography, spacing,
radii, and shadows. Read [theme-system.md](theme-system.md) before writing
new UI.

```dart
// Bad
color: Colors.grey[300]
color: Color(0xFF22C55E)
style: TextStyle(fontSize: 14, color: Colors.red)
BorderRadius.circular(12)

// Good
color: context.colors.outline
color: context.appColors.verdictGreen.dot
style: context.appTextStyles.error.bodyMedium
AppRadius.buttonBorderRadius
```

For verdict / criteria colors always go through `verdict_colors.dart`:

```dart
verdictContainerColor(context, candidate.vc)    // background
onVerdictContainerColor(context, candidate.vc)  // foreground text
verdictColor(context, candidate.vc)             // dot
criteriaIcon(status)                            // icon
```

### Extracting widgets

Don't use private methods to build sub-trees. Extract a class:

```dart
// Bad
Widget _buildVerdictBadge() { return ...; }

// Good — separate StatelessWidget
class _VerdictBadge extends StatelessWidget { ... }
```

Private classes (`_VerdictBadge`) are fine inside the same file when the
widget is tightly coupled to the screen. Move to `widgets/` when it grows
beyond ~40 lines or is reused.

### View file size

Aim for **≤ 200 lines** in a screen file. When it grows past that, refactor:

1. Extract private widget classes to `widgets/`
2. Move inline computations to getters on state or model
3. The screen file should hold only `Scaffold` + `AppBar` + top-level composition

---

## Code generation

Run after editing any `@freezed`, `@JsonSerializable`, or `@injectable` file:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Generated files are **committed to git** and excluded from analysis:
- `*.g.dart` — json_serializable
- `*.freezed.dart` — freezed
- `lib/core/di/injection.config.dart` — injectable_generator
