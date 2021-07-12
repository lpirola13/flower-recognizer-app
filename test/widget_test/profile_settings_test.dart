import 'package:flower_recognizer/app/pages/settings/profile_settings_card.dart';
import 'package:flower_recognizer/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockAuth extends Mock implements AuthBase {}

void main() {

  MockAuth mockAuth;

  setUp((){
    mockAuth = MockAuth();
  });

  Future<void> pumpProfileSettingsCard(WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<AuthBase>(
          create: (_) => mockAuth,
          child: MaterialApp(
            supportedLocales: [Locale('it'), Locale('en')],
            locale: Locale('en'),
            home: ProfileSettingsCard(),
          )
      ),
    );
  }

  group('Test card settings profilo', () {
    testWidgets('',
            (WidgetTester tester) async {
          await pumpProfileSettingsCard(tester);
          await tester.pumpAndSettle();
        });
  });
}