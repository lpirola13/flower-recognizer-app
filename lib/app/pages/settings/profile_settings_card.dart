import 'package:flower_recognizer/app/pages/settings/settings_card.dart';
import 'package:flower_recognizer/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileSettingsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return SettingsCard(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('profile',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,).tr(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircleAvatar(
                backgroundColor: Colors.green[50],
                child: Icon(Icons.person, size: 80, color: Colors.black,),
                radius: 50,
              ),
            ),
            Text((auth.currentUser != null && auth.currentUser.isAnonymous) ? 'anonymous'.tr() : (auth.currentUser != null) ? auth.currentUser.email : 'None')
          ],
        ),
      ),
    );
  }
}