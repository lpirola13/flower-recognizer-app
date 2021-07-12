import 'package:flower_recognizer/app/pages/sign_in/email_signin_page.dart';
import 'package:flower_recognizer/app/pages/sign_in/sign_in_button.dart';
import 'package:flower_recognizer/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class SignInPage extends StatelessWidget {


  Future<void> _signInAnonymous(BuildContext context) async {
    try{
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInAnonymously();
    }catch (e){
      print(e.toString());
    }
  }

  void _signInWithEmail(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage()
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _buildContainer(context)),
    );
  }

  Widget _buildContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 100),
      color: Colors.green[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Image(image: AssetImage('assets/graphics/welcome.png')),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'welcome'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          /* CustomButton(
            onPressed: () {},
            backgroundcolor: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images_button/google-logo.png'),
                Text('Sign in with Google', style: TextStyle(color: Colors.black),),
                Opacity(
                  opacity: 0,
                  child: Image.asset('assets/images_button/google-logo.png')
                ),
              ],
            )
          ), */
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SignInButton(
              text: 'sign_in_email'.tr(),
              color: Colors.green,
              textcolor: Colors.white,
              onPressed: () =>_signInWithEmail(context),
            ),
          ),
          Text(
            'or'.tr(),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SignInButton(
              text: 'anonymous_sign_in'.tr(),
              color: Colors.lime[200],
              textcolor: Colors.black,
              onPressed: () => _signInAnonymous(context),
            ),
          ), 
        ],
      ),
    );
  }
}
