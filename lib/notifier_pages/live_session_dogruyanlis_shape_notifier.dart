
import 'package:flutter/material.dart';

class MyLiveSessionDogruYanlisShapeNotifier extends ChangeNotifier{
  List<Color> borderColors = [
    Colors.transparent,
    Colors.transparent,
  ];


  void changeActivePassive(int index) {
    for (int i = 0; i < borderColors.length; i++) {
      borderColors[i] = Colors.transparent;
    }

    if (index == 0) {
      borderColors[0] = Colors.yellowAccent.shade700;
    } else if (index == 1) {
      borderColors[1] = Colors.yellowAccent.shade700;
    }

    notifyListeners();
  }

}