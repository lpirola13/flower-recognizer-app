import 'package:flower_recognizer/models/language.dart';
import 'package:flutter_test/flutter_test.dart';

void main () {

  group('test model language.dart', () {
    test('il linguaggio viene creato correttamente', () {
      final italiano = Language('italiano', 'it');
      expect(italiano, Language('italiano', 'it'));
    });
  });
}