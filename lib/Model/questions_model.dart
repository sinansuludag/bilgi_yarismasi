class TestModel {
  String nameOfTheTest;
  int numberOfQuestions;
  List<QuestionModel> questions;

  TestModel({
    required this.nameOfTheTest,
    required this.numberOfQuestions,
    required this.questions,
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> questionsJson =
    questions.map((question) => question.toJson()).toList();

    return {
      'name': nameOfTheTest,
      'numberOfQuestions': numberOfQuestions,
      'Questions': questionsJson,
    };
  }

  factory TestModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> questionsJson = json['Questions'] ?? [];
    List<QuestionModel> questions = questionsJson.map((questionJson) {
      return QuestionModel.fromJson(questionJson);
    }).toList();

    return TestModel(
      nameOfTheTest: json['name'] ?? '',
      numberOfQuestions: json['numberOfQuestions'] ?? 0,
      questions: questions,
    );
  }
}

class QuestionModel {
  List<String> answers;
  bool isItQuiz;
  String question;
  int rightAnswer;
  int time;
  int point;

  QuestionModel({
    required this.answers,
    required this.isItQuiz,
    required this.question,
    required this.rightAnswer,
    required this.time,
    required this.point,
  });

  Map<String, dynamic> toJson() {
    List<String> answersJson =
    answers.map((answer) => answer.toString()).toList();

    return {
      'Answers': answersJson,
      'IsItQuiz': isItQuiz,
      'Question': question,
      'RightAnswer': rightAnswer,
      'Time': time,
      'Point': point,
    };
  }

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> answersJson = json['Answers'] ?? [];
    List<String> answers = answersJson.map((answerJson) {
      return answerJson.toString();
    }).toList();

    return QuestionModel(
      answers: answers,
      isItQuiz: json['IsItQuiz'] ?? false,
      question: json['Question'] ?? '',
      rightAnswer: json['RightAnswer'] ?? 0,
      time: json['Time'] ?? 0,
      point: json['Point'] ?? 0,
    );
  }
}


