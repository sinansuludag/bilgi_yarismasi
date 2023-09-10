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

      // Test modelini Firestore JSON verisine dönüştürün
      Map<String, dynamic> testJson = test.toJson();

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

      print('Test ve soruları başarıyla Firestore\'a eklendi');
    } catch (e) {
      print('Firestore veri ekleme hatası: $e');
    }
  }
}
