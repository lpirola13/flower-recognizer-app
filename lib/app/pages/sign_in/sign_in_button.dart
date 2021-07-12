import 'package:flower_recognizer/commond_widgets/custom_button.dart';
import 'package:flutter/material.dart';

class SignInButton extends CustomButton{

  SignInButton({
      String text,
      double height: 50.0,
      Color color,
      Color textcolor,
      double borderRadius: 18.0,
      VoidCallback onPressed,
    }) : super(
      child: Text(
        text,
        style: TextStyle(
          color: textcolor,
          fontSize: 15.0,
          ),
        ),
      height: height,
      borderRadius: borderRadius,
      backgroundcolor: color,
      onPressed: onPressed,
    );


}