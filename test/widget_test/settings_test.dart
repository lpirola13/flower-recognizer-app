import 'package:flower_recognizer/app/pages/settings/language_settings_card.dart';
import 'package:flower_recognizer/app/pages/settings/profile_settings_card.dart';
import 'package:flower_recognizer/app/pages/settings/settings_page.dart';
import 'package:flower_recognizer/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockAuth extends Mock implements AuthBase {}

void main() {
  MockAuth mockAuth;

  setUp(() {
    mockAuth = MockAuth();
  });

  Future<void> pumpSettingsPage(WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<AuthBase>(
          create: (_) => mockAuth,
          child: MaterialApp(
            supportedLocales: [Locale('it'), Locale('en')],
            locale: Locale('en'),
            home: SettingsPage(),
          )),
    );
  }

  group('Test pagina settings', () {
    testWidgets('sono presenti le impostazioni relative al profilo',
        (WidgetTester tester) async {
      await pumpSettingsPage(tester);
      expect(find.byType(ProfileSettingsCard), findsOneWidget);
    });
    testWidgets('sono presenti le impostazioni relative alla lingua',
        (WidgetTester tester) async {
      await pumpSettingsPage(tester);
      expect(find.byType(LanguageSettingsCard), findsOneWidget);
    });
    testWidgets('è presente il tasto di sign out', (WidgetTester tester) async {
      await pumpSettingsPage(tester);
      expect(find.byKey(Key('signout_button')), findsOneWidget);
    });
    testWidgets('Log out test', (WidgetTester tester) async {
      await pumpSettingsPage(tester);
      final logoutButton = find.byKey(Key('signout_button'));
      expect(logoutButton, findsOneWidget);
      tester.tap(logoutButton);
      verifyNever(mockAuth.signOut());
    });
  });
}
