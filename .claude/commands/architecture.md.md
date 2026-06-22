# Architecture reference

Feature-first organization. For most take-homes a lightweight `core / data / features` split is enough and easy to defend. Add a `domain/` layer (entities + use cases + repository interfaces) only if the spec explicitly rewards full Clean Architecture — and say which you chose, and why, in the README.

## Folder layout

```
lib/
├── core/
│   ├── di/                # get_it + injectable setup
│   ├── network/           # dio client + mock interceptor
│   ├── router/            # go_router config
│   ├── theme/             # light/dark ThemeData
│   └── utils/             # debouncer, connectivity, extensions
├── data/
│   ├── models/            # freezed models (Candidate, Criterion, ...)
│   ├── datasources/       # remote (dio) + local (hive)
│   └── repositories/      # CandidateRepository (single source of truth)
├── features/
│   ├── candidates_list/
│   │   ├── cubit/         # state + cubit
│   │   ├── view/          # screen widget
│   │   └── widgets/       # cards, filter chips, sort sheet
│   └── candidate_detail/
│       ├── cubit/
│       ├── view/
│       └── widgets/
├── app.dart               # MaterialApp.router + theme + router
└── main.dart              # bindings, DI init, runApp
```

Keep `features/*/view` thin: a screen reads cubit state and composes small widgets from `widgets/`. Put any non-trivial computation (filter, sort, search match) in pure functions or the cubit so it's unit-testable without a widget.

## pubspec.yaml essentials

```yaml
dependencies:
  flutter: { sdk: flutter }
  flutter_bloc: ^8.1.0
  go_router: ^14.0.0
  get_it: ^7.6.0
  injectable: ^2.4.0
  dio: ^5.4.0
  freezed_annotation: ^2.4.0
  json_annotation: ^4.9.0
  hive: ^2.2.0
  hive_flutter: ^1.1.0
  url_launcher: ^6.2.0
  connectivity_plus: ^6.0.0

dev_dependencies:
  build_runner: ^2.4.0
  freezed: ^2.5.0
  json_serializable: ^6.8.0
  injectable_generator: ^2.6.0
  hive_generator: ^2.0.0
  bloc_test: ^9.1.0
  mocktail: ^1.0.0

flutter:
  assets:
    - mock/   # so the mock JSON is bundled and loadable via rootBundle
```

## DI: get_it + injectable

```dart
// core/di/injection.dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();
```

Annotate concrete classes so the generator wires them:

```dart
@LazySingleton(as: CandidateRepository)
class CandidateRepositoryImpl implements CandidateRepository { ... }

@injectable
class CandidatesListCubit extends Cubit<CandidatesListState> { ... }
```

Register the dio instance and Hive boxes via a `@module`:

```dart
@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio()..interceptors.add(MockInterceptor());
}
```

Call `await configureDependencies()` in `main()` before `runApp`. Run codegen to produce `injection.config.dart`.

## Router: go_router with deep links

```dart
// core/router/app_router.dart
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const CandidatesListScreen(),
      routes: [
        GoRoute(
          path: 'candidate/:id',
          builder: (_, state) =>
              CandidateDetailScreen(id: state.pathParameters['id']!),
        ),
      ],
    ),
  ],
  errorBuilder: (_, __) => const NotFoundScreen(),
);
```

Wire it in `app.dart`:

```dart
MaterialApp.router(
  routerConfig: appRouter,
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  themeMode: ThemeMode.system,
);
```

Navigate with `context.go('/candidate/$id')` (or `context.push` to keep the list under the detail). The `:id` path parameter is what makes deep links work.

## Theme: light + dark

Define both once and let the OS pick. Drive verdict/criteria colors from the theme's `ColorScheme` (or a `ThemeExtension`) rather than hardcoding hex, so dark mode stays readable.

```dart
class AppTheme {
  static final light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    useMaterial3: true,
  );
  static final dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo, brightness: Brightness.dark),
    useMaterial3: true,
  );
}
```

Map domain status to color through a small helper keyed off `Theme.of(context)` so the same green/orange/red reads correctly in both themes.

## analysis_options.yaml

Turn on strict linting — reviewers run `flutter analyze`.

```yaml
include: package:flutter_lints/flutter.yaml
analyzer:
  errors:
    avoid_print: warning
linter:
  rules:
    prefer_const_constructors: true
    require_trailing_commas: true
```