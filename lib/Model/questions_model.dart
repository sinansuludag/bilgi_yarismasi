class TestModel {
  String nameOfTheTest;
  int numberOfQuestions;
  List<QuestionModel> questions;
  String urlPhoto;
  bool isActive; // Yeni eklenen özellikler
  List<String> userNames; // Yeni eklenen özellikler
  List<int> userScores; // Yeni eklenen özellikler
  String userId; // Yeni eklenen özellikler
  int questionIndex; // Yeni eklenen özellikler

  TestModel({
    required this.nameOfTheTest,
    required this.numberOfQuestions,
    required this.questions,
    required this.urlPhoto,
    required this.isActive,
    required this.userNames,
    required this.userScores,
    required this.userId,
    required this.questionIndex,
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> questionsJson =
        questions.map((question) => question.toJson()).toList();

    return {
      'name': nameOfTheTest,
      'numberOfQuestions': numberOfQuestions,
      'urlPhoto': urlPhoto,
      'isActive': isActive,
      'userNames': userNames,
      'userScores': userScores,
      'userId': userId,
      'questionIndex': questionIndex,
      'questions': questionsJson,
    };
  }

  factory TestModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> questionsJson = json['questions'] ?? [];
    List<QuestionModel> questions = questionsJson.map((questionJson) {
      return QuestionModel.fromJson(questionJson);
    }).toList();

    return TestModel(
      nameOfTheTest: json['name'] ?? '',
      numberOfQuestions: json['numberOfQuestions'] ?? 0,
      questions: questions,
      urlPhoto: json['urlPhoto'] ?? '',
      isActive: json['isActive'] ?? false,
      userNames: (json['userNames'] as List<dynamic>?)
              ?.map((userName) => userName.toString())
              .toList() ??
          [],
      userScores: (json['userScores'] as List<dynamic>?)
              ?.map((userScore) => userScore as int)
              .toList() ??
          [],
      userId: json['userId'] ?? '',
      questionIndex: json['questionIndex'] ?? 0,
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
  String urlQuestionPhoto;

  QuestionModel({
    required this.answers,
    required this.isItQuiz,
    required this.question,
    required this.rightAnswer,
    required this.time,
    required this.point,
    required this.urlQuestionPhoto,
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
      'urlQuestionPhoto': urlQuestionPhoto,
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
      urlQuestionPhoto: json['urlQuestionPhoto'] ?? '',
    );
  }
}
