import 'package:flower_recognizer/app/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class HistoryPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('history').tr(),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => _openSettings(context))
        ],
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
          color: Colors.green[50],
        ),
        padding: EdgeInsets.all(16.0),
        //color: Colors.green[50],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8,50,8,20),
                child: Image(image: AssetImage('assets/graphics/homepage.png'),
                fit: BoxFit.fill,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildCorpus(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildCorpus(BuildContext context) {
    return Container(
      key: Key('corpus text'),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Colors.green[100],
      ),
      padding: EdgeInsets.all(30),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: '\n',
          style: TextStyle(
            color:Colors.black,
          ),
          children: [
            TextSpan(text: 'coming_soon'.tr() + '\n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: 1.1)),
          ],
        ),
      )
    );
  }

  void _openSettings(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SettingsPage()));
  }
}
