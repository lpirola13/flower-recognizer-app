import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_recognizer/app/pages/navigation_bar_page.dart';
import 'package:flower_recognizer/app/pages/sign_in/sign_in_page.dart';
import 'package:flower_recognizer/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          final user = snapshot.data;
          if(user == null){
            return SignInPage();
          }
          return NavigationBarPage();//HomePage();
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
    
  }
}