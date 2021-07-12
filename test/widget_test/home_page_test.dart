import 'package:flower_recognizer/app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  group('Home page:', (){
    testWidgets('logo image test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomePage()));
      final logo = find.byType(Image);
      expect(logo, findsOneWidget);
    });

    testWidgets('Corpus text test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomePage()));
      final logo = find.byKey(Key('corpus text'));
      expect(logo, findsOneWidget);
    });

  });

}