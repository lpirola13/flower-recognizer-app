import 'package:easy_localization/easy_localization.dart';
import 'package:flower_recognizer/app/pages/settings/profile_settings_card.dart';
import 'package:flower_recognizer/app/pages/settings/sign_out_button.dart';
import 'package:flower_recognizer/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'language_settings_card.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings').tr(),
        elevation: 3.0,
      ),
      body: Center(child: _buildContainer(context)),
    );
  }

  Widget _buildContainer(BuildContext context) {
    return Container(
        color: Colors.green[50],
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: ProfileSettingsCard(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: LanguageSettingsCard(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: SignOutButton(
                  key: Key('signout_button'),
                  text: 'sign_out'.tr(),
                  onPressed: () => _signOut(context)
                ),
              ),
            ]));
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }

}



