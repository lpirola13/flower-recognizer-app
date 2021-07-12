import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  const CustomButton({Key key, this.child, this.backgroundcolor = Colors.green, @required this.onPressed, this.borderRadius = 18.0, this.height= 50.0, this.elevation,}) : super(key: key);
  
  final Widget child;
  final double height;
  final double elevation;
  final Color backgroundcolor;
  final VoidCallback onPressed;
  final double borderRadius;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        child: child,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundcolor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          elevation: MaterialStateProperty.all(elevation),
        ),
        onPressed: onPressed, 
      ),
    );
  }
}