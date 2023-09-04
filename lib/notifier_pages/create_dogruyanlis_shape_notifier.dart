import 'package:flutter/material.dart';

class MyDogruYanlisShapeNotifier extends ChangeNotifier {
  int timeSleep = 0;
   Color selectColor1=Colors.transparent;
   Color selectColor2=Colors.transparent;

  TextEditingController questionEditController = TextEditingController();
  String questionText = "Soru eklemek için dokunun";
  void changeText(int index) {
    if (index==0 && questionEditController.text != '') {
      questionText = questionEditController.text;
    }
    notifyListeners();
  }

  void changeActivePassive(int index){
    if(index==0){
      selectColor1=Colors.yellowAccent.shade700;
      selectColor2=Colors.blue.shade500;
    }
    else if(index==1){
     selectColor2=Colors.yellowAccent.shade700;
     selectColor1=Colors.red;
    }
    notifyListeners();
  }

  void changeTimeSleep(String time) {
    timeSleep = int.parse(time);
    notifyListeners();
  }
}
