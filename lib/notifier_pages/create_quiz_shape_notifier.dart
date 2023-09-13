import 'dart:io';

import 'package:bilgi_barismasi/Model/questions_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class MyQuizShapeNotifier extends ChangeNotifier {
  int indexOfShownQuestion = 0;
  int timeSleep = 10;
  int point = 1000;
  File? questionsImage;
  String? questionPhotoUrl;
  List<QuestionModel> questionModels = [];


  List<bool> switchIndex = [false, false, false, false];

  void changeSwitchValue(int index) {
    switchIndex = [false, false, false, false];
    switchIndex[index] = true;
    notifyListeners();
  }

  void changeTimeSleep(String time) {
    timeSleep = int.parse(time);
    notifyListeners();
  }

  void changePoint(String puan) {
    point = int.parse(puan);
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

  List<bool> dySwitchIndex = [false, false];

  void dyChangeSwitchValue(int index) {
    dySwitchIndex = [false, false];
    dySwitchIndex[index] = true;
    notifyListeners();
  }

  Future<void> uploadImage(File imageFile) async {
    try {
      String? imageUrl = await uploadImageToFirebaseStorage(imageFile);

      if (imageUrl != null) {
        questionsImage=imageFile;
        questionPhotoUrl=imageUrl;

        notifyListeners();
      }
    } catch (e) {
      print("Hata: $e");
    }
  }

  Future<String?> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      var uuid = Uuid();
      String uniqueId = uuid.v4();

      TaskSnapshot taskSnapshot = await FirebaseStorage.instance
          .ref('images/$uniqueId.png')
          .putFile(imageFile);

      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print("Hata: $e");
      return null;
    }
  }

  void reset() {
    questionText = "Soru eklemek için dokunun"; //index 0
    answer1Text = "Cevap Ekle"; //index 1
    answer2Text = "Cevap Ekle"; //index 2
    answer3Text = "Cevap Ekle"; //index 3
    answer4Text = "Cevap Ekle"; //index 4
    questionEditController = TextEditingController();
    answer1EditController = TextEditingController();
    answer2EditController = TextEditingController();
    answer3EditController = TextEditingController();
    answer4EditController = TextEditingController();
    switchIndex = [false, false, false, false];
    dySwitchIndex = [false, false];
    timeSleep = 10;
    point = 1000;
    questionsImage=null;
    notifyListeners();
  }

  void deleteQuestion(int index) {
    questionModels.removeAt(index);
    if (questionModels.isEmpty) {
      reset();
    } else {
      showQuestion(index);
    }

    notifyListeners();
  }

  void showQuestion(int index) {
    indexOfShownQuestion = index;
    reset();
    QuestionModel questiontoShow = questionModels[index];
    if (questiontoShow.isItQuiz) {
      answer1Text = questiontoShow.answers[0];
      answer2Text = questiontoShow.answers[1];
      answer3Text = questiontoShow.answers[2];
      answer4Text = questiontoShow.answers[3];
      switchIndex[questiontoShow.rightAnswer];
    } else {
      dySwitchIndex[questiontoShow.rightAnswer];
    }
    questionText = questiontoShow.question;
    timeSleep = questiontoShow.time;
    point = questiontoShow.point;
    notifyListeners();
  }

  void addQuestion(bool isItQuiz) {
    if (isItQuiz) {
      if (questionText != "Soru eklemek için dokunun" &&
          answer1Text != "Cevap Ekle" &&
          answer2Text != "Cevap Ekle" &&
          answer3Text != "Cevap Ekle" &&
          answer4Text != "Cevap Ekle"
          ) {
        int answerIndex = -1;
        for (var i = 0; i < 4; i++) {
          if (switchIndex[i] == true) {
            answerIndex = i;
          }
        }
        if (answerIndex != -1) {
          QuestionModel qModel = QuestionModel(
              answers: [answer1Text, answer2Text, answer3Text, answer4Text],
              isItQuiz: isItQuiz,
              question: questionText,
              rightAnswer: answerIndex,
              time: timeSleep,
              point: point, urlQuestionPhoto: '');
          questionModels.add(qModel);
          reset();
          indexOfShownQuestion++;
        }
      }
    } else {
      if (questionText != "Soru eklemek için dokunun" && timeSleep != 0) {
        int answerIndex = -1;
        for (var i = 0; i < 2; i++) {
          if (dySwitchIndex[i] == true) {
            answerIndex = i;
          }
        }
        if (answerIndex != -1) {
          QuestionModel qModel = QuestionModel(
              answers: ["Doğru", "Yanlış"],
              isItQuiz: isItQuiz,
              question: questionText,
              rightAnswer: answerIndex,
              time: timeSleep,
              point: point, urlQuestionPhoto: questionPhotoUrl ?? '');
          questionModels.add(qModel);
          reset();
          indexOfShownQuestion++;
        }
      }
    }
  }
}
