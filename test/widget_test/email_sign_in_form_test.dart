import 'package:flower_recognizer/app/pages/sign_in/email_signin_form.dart';
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

  Future<void> pumpEmailSignInForm(WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<AuthBase>(
        create: (_) => mockAuth,
        child: MaterialApp(
        home: Scaffold(
          body: EmailSignInForm(),
          ),
        ),
      ),
    );
  }

  group('Sign in Email&Psw form: ', (){

    testWidgets('authentication test', (WidgetTester tester) async {
      await pumpEmailSignInForm(tester);
      final signInButton = find.text('sign_in');
      await tester.tap(signInButton);

      verifyNever(mockAuth.signInWithEmailAndPassword('prova@prova.com', 'password'));
    });

    testWidgets('Email & Password TextField test', (WidgetTester tester) async {
      await pumpEmailSignInForm(tester);

      const email = 'prova@prova.com';
      const password = 'password';

      final emailField = find.byKey(Key('email'));
      final passwordField = find.byKey(Key('password'));

      expect(emailField, findsOneWidget); 
      await tester.enterText(emailField, email);

      expect(passwordField, findsOneWidget); 
      await tester.enterText(passwordField, password);

      await tester.pump(); 

      final signInButton = find.text('sign_in');
      await tester.tap(signInButton);

      verify(mockAuth.signInWithEmailAndPassword(email, password)).called(1); 
      //verifyNever(mockAuth.signInWithEmailAndPassword(any, any));
    });
  });

  group('Create user with Email&Psw: ', (){
    testWidgets('fix account test', (WidgetTester tester) async {
      await pumpEmailSignInForm(tester);
      final toggleButton = find.text('register_account');
      expect(toggleButton, findsOneWidget);
      await tester.tap(toggleButton);
      await tester.pump();
      final createAccountButton = find.text('create_account');
      expect(createAccountButton, findsWidgets);

      verifyNever(mockAuth.createUserWithEmailAndPassword('test@test.com', 'password'));
    });

    testWidgets('TextField test', (WidgetTester tester) async {
      await pumpEmailSignInForm(tester);

      const email = 'prova@prova.com';
      const password = 'password';
      
      final emailField = find.byKey(Key('email'));
      final passwordField = find.byKey(Key('password'));

      final toggleButton = find.text('register_account');
      expect(toggleButton, findsOneWidget);
      await tester.tap(toggleButton);
      await tester.pump();

      expect(emailField, findsOneWidget); 
      await tester.enterText(emailField, email);

      expect(passwordField, findsOneWidget); 
      await tester.enterText(passwordField, password);
      
      await tester.pump(); 

      final createAccountButton = find.text('create_account');
      expect(createAccountButton, findsWidgets);

      verifyNever(mockAuth.createUserWithEmailAndPassword(email, password));
    });

    testWidgets('toggle button test', (WidgetTester tester) async {
      await pumpEmailSignInForm(tester);
      final toggleButton = find.text('register_account');
      expect(toggleButton, findsOneWidget);
      await tester.tap(toggleButton);
      await tester.pump();
      final createAccountButton = find.text('create_account');
      expect(createAccountButton, findsWidgets);
    });
  });

}