import 'package:candidate_dashboard/core/network/exceptions/convert_exception.dart';
import 'package:candidate_dashboard/core/network/mixins/comverter_mixin.dart';
import 'package:flutter_test/flutter_test.dart';

class _Converter with ConverterMixin {}

void main() {
  late _Converter converter;

  setUp(() => converter = _Converter());

  group('ConverterMixin.convertType', () {
    test('calls fromJson and returns the result', () {
      final result = converter.convertType<String>(
        {'name': 'Alice'},
        (j) => j['name'] as String,
      );

      expect(result, 'Alice');
    });

    test('wraps fromJson exception in ConvertException', () {
      expect(
        () => converter.convertType<String>(
          {},
          (_) => throw const FormatException('bad'),
        ),
        throwsA(isA<ConvertException>()),
      );
    });

    test('ConvertException.cause holds the original error', () {
      const original = FormatException('bad');

      final exception = catchException<ConvertException>(
        () => converter.convertType<String>({}, (_) => throw original),
      );

      expect(exception.cause, same(original));
    });
  });

  group('ConverterMixin.convertListOfType', () {
    test('maps each element through fromJson', () {
      final result = converter.convertListOfType<int>(
        [
          {'v': 1},
          {'v': 2},
        ],
        (j) => j['v'] as int,
      );

      expect(result, [1, 2]);
    });

    test('empty list returns empty list', () {
      final result = converter.convertListOfType<int>([], (j) => j['v'] as int);

      expect(result, isEmpty);
    });

    test('wraps fromJson exception in ConvertException', () {
      expect(
        () => converter.convertListOfType<int>(
          [
            {'v': 1},
          ],
          (_) => throw const FormatException('bad element'),
        ),
        throwsA(isA<ConvertException>()),
      );
    });
  });
}

T catchException<T extends Object>(void Function() fn) {
  try {
    fn();
  } catch (e) {
    if (e is T) return e;
    rethrow;
  }
  throw StateError('Expected exception of type $T was not thrown');
}
