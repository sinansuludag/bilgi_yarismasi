import 'package:flutter/material.dart';

class MyDogruYanlisShapeNotifier extends ChangeNotifier {
  int timeSleep = 0;
  int point=1000;

  List<bool> dySwitchIndex = [false, false];


  void changeSwitchValue(int index) {
    dySwitchIndex = [false, false];
    dySwitchIndex[index] = true;
    notifyListeners();
  }

  TextEditingController questionEditController = TextEditingController();
  String questionText = "Soru eklemek için dokunun";
  void changeText(int index) {
    if (index==0 && questionEditController.text != '') {
      questionText = questionEditController.text;
    }
    notifyListeners();
  }

  void changePoint(String puan){
    point=int.parse(puan);
    notifyListeners();
  }

  void changeTimeSleep(String time) {
    timeSleep = int.parse(time);
    notifyListeners();
  }
}
