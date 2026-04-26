import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class DetectionService {
  Interpreter? _interpreter;
  List<String> _labels = [];
  bool _isLoaded = false;

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset(
        'assets/plant_disease_model.tflite',
      );
      final labelData = await rootBundle.loadString('assets/class_labels.txt');
      _labels = labelData
          .split('\n')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
      _isLoaded = true;
    } catch (e) {
      print('Error loading model: $e');
    }
  }

  Future<Map<String, dynamic>> predict(File imageFile) async {
    if (!_isLoaded) await loadModel();

    final bytes = await imageFile.readAsBytes();
    img.Image? image = img.decodeImage(bytes);
    if (image == null) return {'error': 'Could not decode image'};

    image = img.copyResize(image, width: 224, height: 224);

    var input = List.generate(
      1,
      (_) => List.generate(
        224,
        (y) => List.generate(224, (x) {
          final pixel = image!.getPixel(x, y);
          return [pixel.r / 255.0, pixel.g / 255.0, pixel.b / 255.0];
        }),
      ),
    );

    var outputShape = _interpreter!.getOutputTensor(0).shape;
    var outputSize = outputShape[1];
    var output = List.filled(1 * outputSize, 0.0).reshape([1, outputSize]);

    _interpreter!.run(input, output);

    final scores = List<double>.from(output[0]);
    final maxIndex = scores.indexOf(scores.reduce(max));
    final confidence = (scores[maxIndex] * 100).toStringAsFixed(1);
    final disease = maxIndex < _labels.length ? _labels[maxIndex] : 'Unknown';

    return {'disease': disease, 'confidence': confidence, 'index': maxIndex};
  }

  void dispose() {
    _interpreter?.close();
  }
}
