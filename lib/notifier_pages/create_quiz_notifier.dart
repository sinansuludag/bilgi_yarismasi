import 'package:bilgi_barismasi/Model/questions_model.dart';
import 'package:bilgi_barismasi/service/remote_datasource.dart';
import 'package:flutter/material.dart';

class CreateQuizNotifier extends ChangeNotifier {
  List<QuestionModel> questions = [];

  TextEditingController testNameController = TextEditingController();

  void addQuestions(List<QuestionModel> questionsFromOtherPage) {
    questions = questionsFromOtherPage;
    notifyListeners();
  }

  void save() {
    if (testNameController.text != '' && questions.isNotEmpty) {
      TestModel newTest = TestModel(
          nameOfTheTest: testNameController.text,
          numberOfQuestions: questions.length,
          questions: questions);
      FirebaseService service = FirebaseService();
      service.addTestToFirestore(newTest);
    }
    questions = [];
    testNameController = TextEditingController();
  }
}
