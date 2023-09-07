import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/questions_model.dart';

class FirebaseService {
  final CollectionReference tests =
      FirebaseFirestore.instance.collection('Tests');

  void getAllTests() async {
    QuerySnapshot querySnapshot = await tests.get();
    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      print(document.id);
    }
  }

  Future<List<TestModel>> getAllTestsFromFirestore() async {
    try {
      List<TestModel> tests = [];

      QuerySnapshot testCollection =
          await FirebaseFirestore.instance.collection('Tests').get();

      for (QueryDocumentSnapshot testDocument in testCollection.docs) {
        if (testDocument.exists) {
          Map<String, dynamic> testJson =
              testDocument.data() as Map<String, dynamic>;

          QuerySnapshot questionsCollection =
              await testDocument.reference.collection('Questions').get();

          List<QuestionModel> questions = [];

          for (QueryDocumentSnapshot questionDocument
              in questionsCollection.docs) {
            if (questionDocument.exists) {
              print("exiat");
              Map<String, dynamic> questionJson =
                  questionDocument.data() as Map<String, dynamic>;
              QuestionModel question = QuestionModel.fromJson(questionJson);
              questions.add(question);
            }
          }

          TestModel test = TestModel.fromJson(testJson);
          test.questions = questions;
          tests.add(test);
        }
      }
      print(tests[0].questions[0].point);

      return tests;
    } catch (e) {
      print('Firestore veri çekme hatası: $e');
      return [];
    }
  }

  Future<void> addDemoTestToFirestore() async {
    try {
      TestModel demoTest = TestModel(
        nameOfTheTest: 'Demo test2',
        numberOfQuestions: 5,
        questions: [
          QuestionModel(
              answers: ['answer1', 'answer2', 'answer3', 'answer4'],
              isItQuiz: true,
              question: 'questiondemo',
              rightAnswer: 0,
              time: 20,
              point: 50),
          QuestionModel(
              answers: ['answer1', 'answer2', 'answer3', 'answer4'],
              isItQuiz: true,
              question: 'questiondemo',
              rightAnswer: 0,
              time: 20,
              point: 60),
          QuestionModel(
              answers: ['answer1', 'answer2', 'answer3', 'answer4'],
              isItQuiz: true,
              question: 'questiondemo',
              rightAnswer: 0,
              time: 20,
              point: 100),
          QuestionModel(
              answers: ['answer1', 'answer2', 'answer3', 'answer4'],
              isItQuiz: true,
              question: 'questiondemo',
              rightAnswer: 0,
              time: 20,
              point: 25),
          QuestionModel(
              answers: ['answer1', 'answer2', 'answer3', 'answer4'],
              isItQuiz: true,
              question: 'questiondemo',
              rightAnswer: 0,
              time: 20,
              point: 50),
        ],
      );

      await FirebaseFirestore.instance.collection('Tests').add({
        'name': demoTest.nameOfTheTest,
        'numberOfQuestions': demoTest.numberOfQuestions,
        'Questions': demoTest.questions.map((question) {
          return {
            'answers': question.answers,
            'isItQuiz': question.isItQuiz,
            'question': question.question,
            'rightAnswer': question.rightAnswer,
            'time': question.time,
          };
        }).toList(),
      });

      print('Demo test Firestore\'a eklendi.');
    } catch (e) {
      print('Demo test eklerken hata oluştu: $e');
    }
  }
}
