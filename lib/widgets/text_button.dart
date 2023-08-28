import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String textButton;
  final Color textColor;
  final double textSize;

  const MyTextButton(
      {Key? key,
      required this.onPressed,
       this.textButton='',
      this.textColor = Colors.white,
      this.textSize = 17})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(textButton,
          style: TextStyle(color: textColor, fontSize: textSize,)),
    );
  }
}
