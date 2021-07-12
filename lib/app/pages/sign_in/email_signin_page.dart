import 'package:flower_recognizer/app/pages/sign_in/email_signin_form.dart';
//import 'package:flower_recognizer/services/auth.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class EmailSignInPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //final auth = Provider.of<AuthBase>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('sign_in').tr(),
        elevation: 2.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: EmailSignInForm(),
        ),
      ),
      backgroundColor: Colors.green[50],
    );
  }
}