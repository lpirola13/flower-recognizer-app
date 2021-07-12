import 'package:flower_recognizer/app/pages/navigation_bar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
void main(){

  group('Navigation bar test: ', (){

    testWidgets('bottom NavigationBar', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: NavigationBarPage()));
      final bottomNavBar = find.byKey(Key('bottomNavigationBar'));
      expect(bottomNavBar, findsOneWidget);
    });

    testWidgets('Icons in', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: NavigationBarPage()));
      final homeLogo = find.byIcon(Icons.home);
      expect(homeLogo, findsWidgets);
      final cameraLogo = find.byKey(Key('cameraLogo'));
      expect(cameraLogo, findsWidgets);
      final flowerLogo = find.byType(ImageIcon);
      expect(flowerLogo, findsWidgets);
    });
  });

}