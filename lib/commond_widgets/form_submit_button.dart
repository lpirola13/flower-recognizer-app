import 'package:flower_recognizer/commond_widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormSubmitButton extends CustomButton{
  FormSubmitButton({
    @required String text,
    @required VoidCallback onPressed,
  }) : super(
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white, 
        fontSize: 20.0,
      ),
    ),
    height: 44.0,
    onPressed: onPressed,
  );
}