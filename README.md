# Candidate Dashboard

HR-приложение для просмотра списка кандидатов. Рекрутер может фильтровать, сортировать, просматривать детали и менять статус обработки резюме — включая работу в офлайн-режиме.

---

## Пакеты

`flutter_bloc` · `go_router` · `get_it` · `injectable` · `dio` · `freezed` · `json_serializable` · `hive_flutter` · `connectivity_plus` · `url_launcher` · `collection` · `flutter_test` · `bloc_test` · `mocktail`

---

## Запуск

**Требования:** Flutter 3.44+ · Dart 3.12+

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Реальный backend не нужен — все запросы перехватывает `MockInterceptor`, данные берутся из `mock/candidates.json`.

---

## Тесты

```bash
flutter test
```

107 тестов: unit (cubits, repository, models, storage, network) + widget.

---

### State management — BLoC/Cubit

### Хранилище — Hive через KVStore-абстракцию

### Архитектура — feature-first, два слоя (data / features)

