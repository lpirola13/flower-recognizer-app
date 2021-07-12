import 'package:flower_recognizer/app/pages/recognizer/loading_image_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';


void main() {

  group('init loading_image_page: ', (){

    testWidgets('button for load an image test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoadingImagePage()));
      final loadImageButton = find.byKey(Key('init_button_loading_image_page'));
      expect(loadImageButton, findsOneWidget);
    });

    testWidgets('button for take a photo test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoadingImagePage()));
      final loadImageButton = find.byKey(Key('init_button_camera_loading_image_page'));
      expect(loadImageButton, findsOneWidget);
    });

    testWidgets('init image in load_image_page test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoadingImagePage()));
      final loadImageButton = find.byKey(Key('init_image_loading_image_page'));
      expect(loadImageButton, findsOneWidget);
    });

  });

  group('ImagePicker', (){
    const MethodChannel channel = MethodChannel('plugins.flutter.io/image_picker');
    final List<MethodCall> log = <MethodCall>[];

    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        return '';
      });

      log.clear();
    });

    group('Function getImage', () {
      test('Image from gallery test', () async {
        final _imagePicker = ImagePicker();
        await _imagePicker.getImage(source: ImageSource.gallery);
        await _imagePicker.getImage(source: ImageSource.camera);

        expect(
          log,
          <Matcher>[
            isMethodCall('pickImage', arguments: <String, dynamic>{
              'source': 1,
              'maxWidth': null,
              'maxHeight': null,
              'imageQuality': null,
              'cameraDevice': 0
            }),
            isMethodCall('pickImage', arguments: <String, dynamic>{
              'source': 0,
              'maxWidth': null,
              'maxHeight': null,
              'imageQuality': null,
              'cameraDevice': 0
            }),
          ],
        );
      });
    });
  });
}