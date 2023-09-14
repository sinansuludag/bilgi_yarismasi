import 'dart:async';

import 'package:bilgi_barismasi/Model/questions_model.dart';
import 'package:bilgi_barismasi/service/remote_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyLiveSessionQuizShapeNotifier extends ChangeNotifier {
  TestModel? test;
  List<QuestionModel>? allQuestions;
  bool isActive = false;
  late String testId;
  int questionIndex = 0;
  double lineWidth = 300;
  int myScore = 0;
  int? myUserIndex;
  List<String> userNames = [];
  List<int> userScores = [];
  bool isTable = false;
  int? solution;
  bool isItNewActive = true;

  void func() {
    Future.delayed(const Duration(seconds: 1), () {
      lineWidth = 0;
    });
    notifyListeners();
  }

  void showLeaderTable() {
    if (test!.numberOfQuestions != (questionIndex + 1)) {
      //score hesaplama

      String uid = FirebaseAuth.instance.currentUser!.uid;
      if (uid == test!.userId) {
        FirebaseService().updateQuestionIndex(testId, questionIndex + 1);
      }

      lineWidth = 300;
      isTable = true;

      nextQuestion();
    } else {
      isTable = true;
      //test bitti
    }
    if (solution != null) {
      if (allQuestions![questionIndex].rightAnswer == solution) {
        myScore += allQuestions![questionIndex].point;
        FirebaseService().updateUserScoreAtIndex(testId, myUserIndex!, myScore);
      }
    }
    notifyListeners();
  }

  void nextQuestion() {
    Future.delayed(const Duration(seconds: 5), () {
      func();
      isTable = false;
      notifyListeners();

      reset();
    });
  }

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _subscription;

  void startListeningToDocument() {
    _subscription = FirebaseService()
        .listenToDocument(testId)
        .listen((documentSnapshot) async {
      final data = documentSnapshot.data() as Map<String, dynamic>;
      test = TestModel.fromJson(data);
      QuerySnapshot questionsCollection =
          await documentSnapshot.reference.collection('Questions').get();
      List<QuestionModel> questions = [];
      notifyListeners();
      for (QueryDocumentSnapshot questionDocument in questionsCollection.docs) {
        if (questionDocument.exists) {
          Map<String, dynamic> questionJson =
              questionDocument.data() as Map<String, dynamic>;
          QuestionModel question = QuestionModel.fromJson(questionJson);
          questions.add(question);
        }
      }

      if (test != null) {
        test!.questions = questions;
        questionIndex = test!.questionIndex;
        userNames = test!.userNames;
        userScores = test!.userScores;
        allQuestions = questions;
        isActive = test!.isActive;
        if (test!.isActive && isItNewActive) {
          //sayfa acildiginda eger bekleme odasinda degilse ona gire animated container bekletilmesi
        }
      }

      notifyListeners();
    });
  }

  List<Map<String, dynamic>> sortUsers() {
    List<Map<String, dynamic>> sortedList = [];

    for (int i = 0; i < userNames.length; i++) {
      sortedList.add({"name": userNames[i], "score": userScores[i]});
      sortedList.sort((a, b) => b["score"].compareTo(a["score"]));
    }
    return sortedList;
  }

  void init(String testID) async {
    testId = testID;
    String uid = FirebaseAuth.instance.currentUser!.uid;

    String userName = await FirebaseService().getUserName(uid);
    myUserIndex = await FirebaseService().addUserToTest(testId, userName, 0);
    startListeningToDocument();

    Future.delayed(const Duration(seconds: 1), () {
      if (test != null) {
        if (uid == test!.userId) {
          //baslatan kisi ise
          FirebaseService().setActiveStatus(
              testID); //baslattiginda diger kullanicilar teste baslayacak
        }
        func();
        notifyListeners();
      }
    });
  }

  void delete() {
    FirebaseService().deleteUserAtIndexFromTest(testId, myUserIndex!);
    isActive = false;
    questionIndex = 0;
    lineWidth = 300;
    myScore = 0;
    userNames = [];
    userScores = [];
    isTable = false;

    reset();
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  List<Color> borderColors = [
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
  ];

  void changeActivePassive(int index) {
    for (int i = 0; i < borderColors.length; i++) {
      borderColors[i] = Colors.transparent;
      solution = null;
    }

    if (index == 0) {
      borderColors[0] = Colors.white;
      solution = 0;
    } else if (index == 1) {
      borderColors[1] = Colors.white;
      solution = 1;
    } else if (index == 2) {
      borderColors[2] = Colors.white;
      solution = 2;
    } else if (index == 3) {
      borderColors[3] = Colors.white;
      solution = 3;
    }

    notifyListeners();
  }

  void reset() {
    borderColors = [
      Colors.transparent,
      Colors.transparent,
      Colors.transparent,
      Colors.transparent,
    ];
    dyBorderColors = [
      Colors.transparent,
      Colors.transparent,
    ];
  }

  List<Color> dyBorderColors = [
    Colors.transparent,
    Colors.transparent,
  ];

  void dyChangeActivePassive(int index) {
    for (int i = 0; i < dyBorderColors.length; i++) {
      dyBorderColors[i] = Colors.transparent;
      solution = null;
    }

    if (index == 0) {
      dyBorderColors[0] = Colors.white;
      solution = 0;
    } else if (index == 1) {
      dyBorderColors[1] = Colors.white;
      solution = 1;
    }

    notifyListeners();
  }
}
