import 'package:flower_recognizer/app/pages/sign_in/sign_in_page.dart';
import 'package:flower_recognizer/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockAuth extends Mock implements AuthBase {}

void main(){

  MockAuth mockAuth;

  setUp((){
    mockAuth = MockAuth();
  });

  Future<void> pumpSignInPage(WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<AuthBase>(
        create: (_) => mockAuth,
        child: MaterialApp(
        home: Scaffold(
          body: SignInPage(),
          ),
        ),
      ),
    );
  }

  group('Sign in page: ', (){

    testWidgets('Anonymous sign in test', (WidgetTester tester) async {
      await pumpSignInPage(tester);
      final anonymousButton = find.text('anonymous_sign_in');
      expect(anonymousButton, findsOneWidget);
      await tester.tap(anonymousButton);

      verify(mockAuth.signInAnonymously());
    });

  });



}