import 'package:flutter/material.dart';

class MyDogruYanlisShapeNotifier extends ChangeNotifier {
  int timeSleep = 0;
  TextEditingController questionEditController = TextEditingController();
  TextEditingController answer1EditController = TextEditingController();
  TextEditingController answer2EditController = TextEditingController();
  String questionText = "Soru eklemek için dokunun"; //index 0
  String answer1Text = "Cevap Ekle"; //index 1
  String answer2Text = "Cevap Ekle"; //index 2
  void changeText(TextEditingController controller, int index) {
    if (controller.text != '') {
      if (index == 0) {
        questionText = controller.text;
      } else if (index == 1) {
        answer1Text = controller.text;
      } else {
        answer2Text = controller.text;
      }
      notifyListeners();
    }
  }

  void changeTimeSleep(String time) {
    timeSleep = int.parse(time);
    notifyListeners();
  }
}
