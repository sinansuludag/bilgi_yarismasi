import 'package:flutter/material.dart';

class MyDogruYanlisShapeNotifier extends ChangeNotifier {
  int timeSleep = 0;
  TextEditingController questionEditController = TextEditingController();
  TextEditingController answer1EditController = TextEditingController();
  TextEditingController answer2EditController = TextEditingController();
  String questionText = "Soru eklemek için dokunun"; //index 0
  String answer1Text = "Cevap Ekle"; //index 1
  String answer2Text = "Cevap Ekle"; //index 2
  void changeText(int index) {
    if (index == 0 && questionEditController.text != '') {
      questionText = questionEditController.text;
    } else if (index == 1 && answer1EditController.text != '') {
      answer1Text = answer1EditController.text;
    } else if (index == 2 && answer2EditController.text != '') {
      answer2Text = answer2EditController.text;
    }
    notifyListeners();
  }

  void changeTimeSleep(String time) {
    timeSleep = int.parse(time);
    notifyListeners();
  }
}
