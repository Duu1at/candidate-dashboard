# Candidate Dashboard

HR candidate review app built with Flutter. Displays a list of candidates pre-screened by an AI model, lets a recruiter filter, sort, and change candidate statuses.

---

## Tech stack

| | |
| --- | --- |
| UI | Flutter 3.44 · Material 3 · custom design system |
| State | flutter_bloc (Cubit) |
| Navigation | go_router |
| DI | get_it + injectable |
| Network | dio + MockInterceptor (no real backend) |
| Persistence | hive_flutter (offline cache + local status overrides) |
| Models | freezed + json_serializable |

---

## Features

- Candidate list with search, verdict filter, and sort (name / experience / date)
- Infinite scroll pagination (10 per page)
- Offline mode — falls back to Hive cache, shows banner
- Candidate detail: contacts, AI verdict badge, criteria checklist, experience, stack, interview questions
- Status selector with optimistic update and rollback on API error
- Light / dark theme (follows system)

---

## Getting started

**Prerequisites:** Flutter 3.44+ · Dart 3.12+

```bash
# Install dependencies
flutter pub get

# Run on a connected device or simulator
flutter run
```

No backend setup required — all network traffic is intercepted by `MockInterceptor`,
which serves data from `mock/candidates.json`.

---

## Code generation

Run after editing any `@freezed`, `@JsonSerializable`, or `@injectable` annotated file:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Generated files (`*.g.dart`, `*.freezed.dart`, `injection.config.dart`) are committed to git.

---

## Project structure

```
lib/
├── core/          # DI, router, theme, utils
├── data/          # models, datasources (remote/local), repository
├── features/
│   ├── candidates_list/   # list screen + cubit + widgets
│   └── candidate_detail/  # detail screen + cubit + widgets
├── app.dart
└── main.dart
mock/
└── candidates.json        # mock API data
```

---

## Docs

| File | What it covers |
| --- | --- |
| [docs/architecture.md](docs/architecture.md) | Folder layout, layers, data flow, DI, navigation |
| [docs/theme-system.md](docs/theme-system.md) | Color tokens, typography, spacing, radii, shadows |
| [docs/code-rules.md](docs/code-rules.md) | Naming, Freezed patterns, Cubit conventions, widget rules |
