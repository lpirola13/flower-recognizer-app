import 'dart:io';
import 'dart:typed_data';
import 'package:flower_recognizer/models/prediction.dart';
import 'package:logging/logging.dart';
import 'package:image/image.dart' as img;
import 'package:tflite/tflite.dart';

abstract class RecognizerService {
  Future<String> loadModel();

  Uint8List imagePreprocessing(img.Image image);

  Future<List<Prediction>> runModelOnImage(File file);

  Future<void> closeModel();
}

class TfliteService implements RecognizerService {
  final _log = Logger('TfliteService');
  bool isModelLoaded = false;
  final String modelPath = "assets/models/mobilenet.tflite";
  final String labelsPath = "assets/models/labels.txt";



  @override
  Future<String> loadModel() async {
    String result =
        await Tflite.loadModel(model: modelPath, labels: labelsPath);
    if (result == 'success') {
      _log.info('loadModel - $result');
      isModelLoaded = true;
      return result;
    } else {
      _log.severe('loadModel - $result');
      return result;
    }
  }

  @override
  Uint8List imagePreprocessing(img.Image image) {
    const int size = 224;
    const double mean = 127.5;
    const double std = 127.5;

    img.Image imageResized = img.copyResize(image,
        height: size, width: size, interpolation: img.Interpolation.linear);

    _log.info(
        'imagePreprocessing - image: width ${image.width} height: ${image.height}');
    _log.info(
        'imagePreprocessing - resized image: width ${imageResized.width} height: ${imageResized.height}');

    var convertedBytes = Float32List(1 * size * size * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < size; i++) {
      for (var j = 0; j < size; j++) {
        var pixel = imageResized.getPixel(j, i);
        buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  @override
  Future<List<Prediction>> runModelOnImage(File file) async {
    List<Prediction> predictions = [];

    img.Image image = img.decodeImage(await file.readAsBytes());

    String result = 'success';

    if (!isModelLoaded) {
      result = await loadModel();
    }

    if (result == 'success') {
      try {
        Uint8List bytes = imagePreprocessing(image);

        var recognitions = await Tflite.runModelOnBinary(
            binary: bytes, // required
            numResults: 102,
            threshold: 0,
            asynch: true);

        recognitions.forEach((value) {
          if (value['confidence'] <= 1) {
            predictions.add(Prediction(
                value['index'], value['label'], value['confidence']));
          }
        });

        closeModel();
        _log.info('runModelOnImage - predictions done');
        return predictions.sublist(0, 5);
      } catch (error) {
        _log.severe('runModelOnImage - something went wrong');
        closeModel();
        return predictions;
      }
    } else {
      _log.severe('runModelOnImage - could not load model');
      closeModel();
      return predictions;
    }
  }

  @override
  Future<void> closeModel() async {
    isModelLoaded = false;
    Tflite.close();
  }
}
