
import 'package:flower_recognizer/models/prediction.dart';
import 'package:flutter_test/flutter_test.dart';

void main () {

  group('test model prediction.dart', () {

    test('la prediction viene creata correttamente', () {
      final prediction = Prediction(100, 'label', 0.98);
      expect(prediction, Prediction(100, 'label', 0.98));
    });

    test('la prediction viene creata correttamente da una mappa', () {
      final prediction = Prediction.fromMap({'index' : 100, 'label' : 'label', 'confidence' : 0.98});
      expect(prediction, Prediction(100, 'label', 0.98));
    });

    test('la prediction viene convertita correttamente in una mappa', () {
      final prediction = Prediction(100, 'label', 0.98);
      final predictionMap = {'index' : 100, 'label' : 'label', 'confidence' : 0.98};
      expect(prediction.toMap(), predictionMap);
    });
  });
}