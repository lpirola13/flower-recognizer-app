import 'package:easy_localization/easy_localization.dart';
import 'package:flower_recognizer/app/pages/settings/settings_card.dart';
import 'package:flower_recognizer/models/language.dart';
import 'package:flutter/material.dart';

class LanguageSettingsCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('language', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),).tr(),
            DropdownButton<String>(
              key: Key('language_dropdown'),
              isExpanded: true,
              value: _getLanguage(context),
              items: _buildLanguagesList(),
              onChanged: (String value) => _setLanguage(context, value),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildLanguagesList() {
    return <Language>[
      Language('italian'.tr(), 'it'),
      Language('english'.tr(), 'en')
    ].map<DropdownMenuItem<String>>((Language value) {
      return DropdownMenuItem<String>(
        value: value.locale,
        child: Text(value.language),
      );
    }).toList();
  }

  void _setLanguage(BuildContext context, String value) {
    EasyLocalization.of(context).setLocale(Locale(value));
  }

  String _getLanguage(BuildContext context) {
    return Localizations.localeOf(context).toString();
  }
}
