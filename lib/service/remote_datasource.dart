import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/questions_model.dart';

class FirebaseService {
  final CollectionReference tests =
      FirebaseFirestore.instance.collection('Tests');

  Future<List<TestModel>> getAllTestsFromFirestore() async {
    try {
      List<TestModel> tests = [];

      QuerySnapshot testCollection =
          await FirebaseFirestore.instance.collection('Tests').get();

      for (QueryDocumentSnapshot testDocument in testCollection.docs) {
        if (testDocument.exists) {
          Map<String, dynamic> testJson =
              testDocument.data() as Map<String, dynamic>;

          UserModel user = UserModel.fromJson(testJson['user'] ?? {});

          QuerySnapshot questionsCollection =
              await testDocument.reference.collection('Questions').get();

          List<QuestionModel> questions = [];

          for (QueryDocumentSnapshot questionDocument
              in questionsCollection.docs) {
            if (questionDocument.exists) {
              Map<String, dynamic> questionJson =
                  questionDocument.data() as Map<String, dynamic>;
              QuestionModel question = QuestionModel.fromJson(questionJson);

              questions.add(question);
            }
          }

          TestModel test = TestModel.fromJson(testJson);
          test.user = user;
          test.questions = questions;
          tests.add(test);
        }
      }

      return tests;
    } catch (e) {
      print('Firestore veri çekme hatası: $e');
      return [];
    }
  }

  Future<void> addTestToFirestore(TestModel test) async {
    try {
      // Firestore'da yeni bir test koleksiyonu referansı oluşturun
      CollectionReference testCollection =
          FirebaseFirestore.instance.collection('Tests');

    // UserModel'i Firestore JSON verisine dönüştürün
      Map<String, dynamic> userJson = test.user.toJson();

      // Test modelini Firestore JSON verisine dönüştürün
      Map<String, dynamic> testJson = test.toJson();

      // UserModel bilgilerini test JSON verisine ekleyin
      testJson['user'] = userJson;

      // Firestore'daki test koleksiyonuna yeni bir belge ekleyin
      DocumentReference newDocumentReference =
          await testCollection.add(testJson);

      // Soru koleksiyonunu eklemek isterseniz aşağıdaki kodu kullanabilirsiniz:
      CollectionReference questionsCollection =
          newDocumentReference.collection('Questions');

      for (QuestionModel question in test.questions) {
        Map<String, dynamic> questionJson = question.toJson();
        await questionsCollection.add(questionJson);
      }

     /* TestModel testDemo=TestModel(nameOfTheTest: "Soru Basligi", numberOfQuestions: 5, questions: [QuestionModel(answers: ["cevap1","cevap2","cevap3","cevap4"], isItQuiz: true, question: "Soru1", rightAnswer: 2, time: 10, point: 50)], user: UserModel(id: "1", name: "ali", email: "ali123@gmail.com", password: "123456"));
      testDemo.toJson();
      addTestToFirestore(testDemo);*/
      print('Test ve soruları başarıyla Firestore\'a eklendi');
    } catch (e) {
      print('Firestore veri ekleme hatası: $e');
    }
  }
}
