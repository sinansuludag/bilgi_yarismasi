import 'dart:async';
import 'package:bilgi_barismasi/Model/questions_model.dart';
import 'package:bilgi_barismasi/service/remote_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar.dart';

class MyLiveSessionQuizShapeNotifier extends ChangeNotifier {
  TestModel? test;
  List<QuestionModel>? allQuestions;
  bool isActive = false;
  late String testId;
  int questionIndex = 0;
  DateTime? questionStart;
  DateTime? questionSolved;
  int myScore = 0;
  int? myUserIndex;
  List<String> userNames = [];
  List<int> userScores = [];
  bool isTable = false;
  int? solution;
  bool isItNewActive = true;
  bool isAnswer = false;
  late num questionPoint;
  late num gecensure;

  //Burada gecen süreyi nasıl tutacagımı bilemedim onu tutmamız gerekiyor.

  num scoreOfTheQuestion() {
    num puan = allQuestions![questionIndex].point;
    num time = allQuestions![questionIndex].time;
    questionPoint = (puan) - (puan / time) * gecensure;
    return questionPoint;
  }

  void showLeaderTable(BuildContext context) {
    if (test!.numberOfQuestions != (questionIndex + 1)) {
      //score hesaplama

      String uid = FirebaseAuth.instance.currentUser!.uid;
      if (uid == test!.userId) {
        FirebaseService().updateQuestionIndex(testId, questionIndex + 1);
      }
      isTable = true;
      nextQuestion();
    } else {
      isTable = true;
      Future.delayed(
        const Duration(seconds: 5),
        () {
         /* Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MyBottomNavigationBar()),
          );*/
          //isTable = false;
          notifyListeners();
        },
      );
    }

    notifyListeners();
  }

  void nextQuestion() {
    Future.delayed(const Duration(seconds: 5), () {
      isTable = false;
      notifyListeners();
      questionStart = DateTime.now();
      questionSolved = null;

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
          isItNewActive = false;
          questionStart = DateTime.now();
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

        notifyListeners();
      }
    });
  }

  void delete() {
    FirebaseService().deleteUserAtIndexFromTest(testId, myUserIndex!);
    isActive = false;
    questionIndex = 0;

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
    if (solution != null) {
      for (int i = 0; i < dyBorderColors.length; i++) {
        borderColors[i] = Colors.transparent;
      }
    }
    if (index >= 0 && index < borderColors.length) {
      borderColors[index] = Colors.white;
      solution = index;
    }
    questionSolved = DateTime.now();

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
    if (solution != null) {
      for (int i = 0; i < dyBorderColors.length; i++) {
        dyBorderColors[i] = Colors.transparent;
      }
    }
    if (index >= 0 && index < dyBorderColors.length) {
      dyBorderColors[index] = Colors.white;
      solution = index;
    }
    questionSolved = DateTime.now();

    notifyListeners();
  }

  int calculateScore() {
    int newScore = 0;
    if (questionStart != null && questionSolved != null) {
      Duration elapsedTime = questionSolved!.difference(questionStart!);
      newScore = allQuestions![questionIndex].point -
          allQuestions![questionIndex].point ~/
              (elapsedTime.inSeconds * allQuestions![questionIndex].time);
    }
    return newScore;
  }

  void showScore(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        showLeaderTable(context);
      },
    );
    if (solution != null) {
      if (solution == allQuestions![questionIndex].rightAnswer) {
        int newScore = calculateScore();
        myScore += newScore;
        FirebaseService().updateUserScoreAtIndex(testId, myUserIndex!, myScore);

        if (allQuestions![questionIndex].isItQuiz) {
          borderColors[solution!] = Colors.green.shade500;
        } else {
          dyBorderColors[solution!] = Colors.green.shade500;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green.shade500,
            duration: const Duration(seconds: 2),
            content: Text(
              "Soruda kazanılan puan $newScore",
              style: const TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        if (allQuestions![questionIndex].isItQuiz) {
          borderColors[solution!] = Colors.red.shade500;
          borderColors[allQuestions![questionIndex].rightAnswer] =
              Colors.green.shade500;
        } else {
          dyBorderColors[solution!] = Colors.red.shade500;
          dyBorderColors[allQuestions![questionIndex].rightAnswer] =
              Colors.green.shade500;
        }
        notifyListeners();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
            content: Text(
              "Yanlış cevapladınız",
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }
  }
}
