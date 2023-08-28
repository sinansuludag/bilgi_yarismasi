import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final double iconSize;

  const MyIconButton(
      {Key? key,
      required this.onPressed,
      required this.icon,
      required this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
     iconSize: iconSize,
    );
  }
}
