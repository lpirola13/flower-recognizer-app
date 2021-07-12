import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {

  const SettingsCard({Key key, this.child, this.borderRadius = 18.0,})
      : super(key: key);

  final Widget child;
  final double borderRadius;


  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: child
      ),
    );
  }
}
