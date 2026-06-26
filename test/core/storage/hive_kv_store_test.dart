import 'package:candidate_dashboard/core/storage/hive_kv_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

class _MockBox extends Mock implements Box<String> {}

void main() {
  group('HiveKVStore', () {
    late _MockBox box;
    late HiveKVStore store;

    setUp(() {
      box = _MockBox();
      store = HiveKVStore(box);
    });

    group('readObject', () {
      test('key missing: returns null', () async {
        when(() => box.get('k')).thenReturn(null);

        final result = await store.readObject<Map<String, dynamic>>(
          'k',
          fromJson: (j) => j,
        );

        expect(result, isNull);
      });

      test('valid JSON: deserializes via fromJson', () async {
        when(() => box.get('k')).thenReturn('{"id":1}');

        final result = await store.readObject<Map<String, dynamic>>(
          'k',
          fromJson: (j) => j,
        );

        expect(result, {'id': 1});
      });

      test('corrupt JSON: returns null without throwing', () async {
        when(() => box.get('k')).thenReturn('not-json{{');

        final result = await store.readObject<Map<String, dynamic>>(
          'k',
          fromJson: (j) => j,
        );

        expect(result, isNull);
      });

      test('fromJson throws: returns null without rethrowing', () async {
        when(() => box.get('k')).thenReturn('{"x":1}');

        final result = await store.readObject<String>(
          'k',
          fromJson: (_) => throw Exception('bad'),
        );

        expect(result, isNull);
      });
    });

    group('readList', () {
      test('key missing: returns null', () async {
        when(() => box.get('k')).thenReturn(null);

        final result = await store.readList<int>(
          'k',
          fromJson: (j) => j['v'] as int,
        );

        expect(result, isNull);
      });

      test('valid JSON array: deserializes each element', () async {
        when(() => box.get('k')).thenReturn('[{"v":1},{"v":2}]');

        final result = await store.readList<int>(
          'k',
          fromJson: (j) => j['v'] as int,
        );

        expect(result, [1, 2]);
      });

      test('corrupt JSON: returns null without throwing', () async {
        when(() => box.get('k')).thenReturn('[broken');

        final result = await store.readList<int>(
          'k',
          fromJson: (j) => j['v'] as int,
        );

        expect(result, isNull);
      });

      test('fromJson throws on one element: returns null', () async {
        when(() => box.get('k')).thenReturn('[{"v":1}]');

        final result = await store.readList<int>(
          'k',
          fromJson: (_) => throw Exception('bad element'),
        );

        expect(result, isNull);
      });
    });

    group('writeObject', () {
      test('serializes value to JSON and writes to box', () async {
        when(() => box.put(any(), any())).thenAnswer((_) async {});

        await store.writeObject<Map<String, dynamic>>(
          'k',
          {'id': 42},
          toJson: (v) => v,
        );

        verify(() => box.put('k', '{"id":42}')).called(1);
      });
    });

    group('writeList', () {
      test('serializes list to JSON array and writes to box', () async {
        when(() => box.put(any(), any())).thenAnswer((_) async {});

        await store.writeList<Map<String, dynamic>>(
          'k',
          [
            {'a': 1},
            {'a': 2},
          ],
          toJson: (v) => v,
        );

        verify(() => box.put('k', '[{"a":1},{"a":2}]')).called(1);
      });

      test('empty list writes an empty JSON array', () async {
        when(() => box.put(any(), any())).thenAnswer((_) async {});

        await store.writeList<Map<String, dynamic>>(
          'k',
          [],
          toJson: (v) => v,
        );

        verify(() => box.put('k', '[]')).called(1);
      });
    });

    group('delete', () {
      test('delegates to box.delete', () async {
        when(() => box.delete(any())).thenAnswer((_) async {});

        await store.delete('k');

        verify(() => box.delete('k')).called(1);
      });
    });
  });
}
