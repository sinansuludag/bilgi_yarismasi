import 'package:flutter/material.dart';

class MyLiveSessionQuizShapeNotifier extends ChangeNotifier {
  List<Color> borderColors = [
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
  ];

  void changeActivePassive(int index) {
    for (int i = 0; i < borderColors.length; i++) {
      borderColors[i] = Colors.transparent;
    }

    if (index == 0) {
      borderColors[0] = Colors.white;
    } else if (index == 1) {
      borderColors[1] = Colors.white;
    } else if (index == 2) {
      borderColors[2] =  Colors.white;
    } else if (index == 3) {
      borderColors[3] = Colors.white;
    }

    notifyListeners();
  }

  List<Color> dyBorderColors = [
    Colors.transparent,
    Colors.transparent,
  ];

  void dyChangeActivePassive(int index) {
    for (int i = 0; i < dyBorderColors.length; i++) {
      dyBorderColors[i] = Colors.transparent;
    }

    if (index == 0) {
      dyBorderColors[0] = Colors.white;
    } else if (index == 1) {
      dyBorderColors[1] = Colors.white;
    }

    notifyListeners();
  }
}
