import 'package:flower_recognizer/app/pages/settings/language_settings_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpLanguageSettingsCard(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      supportedLocales: [Locale('it'), Locale('en')],
      locale: Locale('en'),
      home: LanguageSettingsCard(),
    ));
  }

  group('Test card settings lingua', () {
    testWidgets('è possibile scegliere l\'inglese o l\'italiano',
            (WidgetTester tester) async {
          await pumpLanguageSettingsCard(tester);
          await tester.pumpAndSettle();
          final languageDropdown = find.byKey(Key('language_dropdown'));
          expect(languageDropdown, findsOneWidget);
          await tester.tap(languageDropdown);
          expect(find.text('english'), findsOneWidget);
          expect(find.text('italian'), findsOneWidget);
        });
  });
}