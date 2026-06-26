import 'package:candidate_dashboard/data/data.dart';
import 'package:flutter_test/flutter_test.dart';

CandidateModel _make({
  String name = 'Test User',
  String stack = '',
  String edu = '',
}) => CandidateModel(
  id: '1',
  name: name,
  position: '',
  posLabel: '',
  file: '',
  email: '',
  phone: '',
  city: '',
  tg: '',
  exp: const [],
  totalExp: '',
  stack: stack,
  edu: edu,
  verdict: '',
  vc: '',
  criteria: const [],
  summary: '',
  questions: const [],
);

void main() {
  group('CandidateModel.initials', () {
    test('two words: takes first letters of first and last word', () {
      expect(_make(name: 'Иван Иванов').initials, 'ИИ');
    });

    test('three words: takes first letters of first two words', () {
      expect(_make(name: 'Иван Петрович Иванов').initials, 'ИП');
    });

    test('single word: takes its first letter', () {
      expect(_make(name: 'Иван').initials, 'И');
    });

    test('leading and trailing spaces are ignored', () {
      expect(_make(name: '  Иван   Иванов  ').initials, 'ИИ');
    });

    test('multiple inner spaces between words are collapsed', () {
      expect(_make(name: 'Иван   Иванов').initials, 'ИИ');
    });

    test('empty string returns question mark', () {
      expect(_make(name: '').initials, '?');
    });

    test('only whitespace returns question mark', () {
      expect(_make(name: '   ').initials, '?');
    });

    test('result is always uppercase', () {
      expect(_make(name: 'alice bob').initials, 'AB');
    });
  });

  group('CandidateModel.stackTags', () {
    test('comma-separated items become a list', () {
      expect(
        _make(stack: 'Flutter, Dart, Firebase').stackTags,
        ['Flutter', 'Dart', 'Firebase'],
      );
    });

    test('surrounding whitespace is trimmed from each tag', () {
      expect(
        _make(stack: '  Flutter ,  Dart  ').stackTags,
        ['Flutter', 'Dart'],
      );
    });

    test('single item returns a one-element list', () {
      expect(_make(stack: 'Flutter').stackTags, ['Flutter']);
    });

    test('empty string returns empty list', () {
      expect(_make(stack: '').stackTags, isEmpty);
    });

    test('string of only commas and spaces returns empty list', () {
      expect(_make(stack: ' , , ').stackTags, isEmpty);
    });
  });

  group('CandidateModel.eduInstitution', () {
    test('returns text before the first comma', () {
      expect(
        _make(edu: 'КГТУ, Информационные технологии, 2018').eduInstitution,
        'КГТУ',
      );
    });

    test('trims surrounding whitespace', () {
      expect(
        _make(edu: '  КГТУ  , Информационные технологии').eduInstitution,
        'КГТУ',
      );
    });

    test('no comma: returns the whole string', () {
      expect(_make(edu: 'КГТУ').eduInstitution, 'КГТУ');
    });

    test('empty string: returns empty string', () {
      expect(_make(edu: '').eduInstitution, '');
    });
  });

  group('CandidateModel.eduDetails', () {
    test('returns text after the first comma', () {
      expect(
        _make(edu: 'КГТУ, Информационные технологии, 2018').eduDetails,
        'Информационные технологии, 2018',
      );
    });

    test('trims leading whitespace after the comma', () {
      expect(
        _make(edu: 'КГТУ,   Информационные технологии').eduDetails,
        'Информационные технологии',
      );
    });

    test('no comma: returns empty string', () {
      expect(_make(edu: 'КГТУ').eduDetails, '');
    });

    test('empty string: returns empty string', () {
      expect(_make(edu: '').eduDetails, '');
    });
  });
}
