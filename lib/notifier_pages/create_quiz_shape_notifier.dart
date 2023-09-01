import 'package:flutter/material.dart';

class MyQuizShapeNotifier extends ChangeNotifier {
  int timeSleep = 0;
  void changeTimeSleep(String time) {
    timeSleep = int.parse(time);
    notifyListeners();
  }

  TextEditingController questionEditController = TextEditingController();
  TextEditingController answer1EditController = TextEditingController();
  TextEditingController answer2EditController = TextEditingController();
  TextEditingController answer3EditController = TextEditingController();
  TextEditingController answer4EditController = TextEditingController();

  String questionText = "Soru eklemek için dokunun"; //index 0
  String answer1Text = "Cevap Ekle"; //index 1
  String answer2Text = "Cevap Ekle"; //index 2
  String answer3Text = "Cevap Ekle"; //index 3
  String answer4Text = "Cevap Ekle"; //index 4
  void changeText(int index) {
    if (index == 0 && questionEditController.text != '') {
      questionText = questionEditController.text;
    } else if (index == 1 && answer1EditController.text != '') {
      answer1Text = answer1EditController.text;
    } else if (index == 2 && answer2EditController.text != '') {
      answer2Text = answer2EditController.text;
    } else if (index == 3 && answer3EditController.text != '') {
      answer3Text = answer3EditController.text;
    } else if (index == 4 && answer4EditController.text != '') {
      answer4Text = answer4EditController.text;
    }
    notifyListeners();
  }
}
