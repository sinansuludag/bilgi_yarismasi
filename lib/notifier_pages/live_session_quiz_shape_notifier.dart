import 'dart:async';

import 'package:bilgi_barismasi/Model/questions_model.dart';
import 'package:bilgi_barismasi/service/remote_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyLiveSessionQuizShapeNotifier extends ChangeNotifier {
  TestModel? test;
  late String testId;
  int questionIndex = 0;

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
      }
    });
    notifyListeners();
  }

  @override
  void initState(String testID) {
    testId = testID;
    startListeningToDocument();
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
    }

    if (index == 0) {
      borderColors[0] = Colors.white;
    } else if (index == 1) {
      borderColors[1] = Colors.white;
    } else if (index == 2) {
      borderColors[2] = Colors.white;
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
