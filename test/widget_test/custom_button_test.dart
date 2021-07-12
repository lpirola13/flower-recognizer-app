import 'package:flower_recognizer/commond_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  testWidgets('onPressed Callback', (WidgetTester tester) async {
    var pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: CustomButton(
          child: Text('tap me'),
          onPressed: () { pressed = true; }),
      )
    );

    final button = find.byType(ElevatedButton);
    expect(button, findsOneWidget);
    expect(find.text('tap me'), findsOneWidget);
    
    await tester.tap(button);
    expect(pressed, true);
  });

}