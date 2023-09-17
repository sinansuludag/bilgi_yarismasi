import 'dart:io';
import 'package:bilgi_barismasi/Model/questions_model.dart';
import 'package:bilgi_barismasi/service/remote_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CreateQuizNotifier extends ChangeNotifier {
  File? coverImage;
  List<QuestionModel> questions = [];
  TextEditingController testNameController = TextEditingController();
  String urlPhoto = ''; // Eklediğimiz urlPhoto değişkeni

  void addQuestions(List<QuestionModel> questionsFromOtherPage) {
    questions = questionsFromOtherPage;
    notifyListeners();
  }



  Future<void> uploadCoverImage(File imageFile) async {
    try {
      String? imageUrl = await uploadImageToFirebaseStorage(imageFile);

      if (imageUrl != null){
        coverImage = imageFile;

        // Cover image'ın URL'sini urlPhoto değişkenine ata
        urlPhoto = imageUrl;

        notifyListeners();
      }
    } catch (e) {
      print("Hata: $e");
    }
  }

  Future<String?> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      var uuid = const Uuid();
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

  void save() {
    if (testNameController.text.isNotEmpty && questions.isNotEmpty) {
      var user = FirebaseAuth.instance.currentUser;
      String userId;
      if (user != null) {
        userId = user.uid;
      } else {
        userId = '';
      }
      TestModel newTest = TestModel(
        userId: userId,
        isActive: false,
        questionIndex: 0,
        userNames: [],
        userScores: [],
        nameOfTheTest: testNameController.text,
        numberOfQuestions: questions.length,
        questions: questions,
        urlPhoto: urlPhoto, // urlPhoto değişkenini kullan
      );

      FirebaseService service = FirebaseService();
      service.addTestToFirestore(newTest);
    }

    // Değişkenleri temizle
    questions.clear();
    testNameController.clear();
    coverImage = null;
    urlPhoto = '';

    notifyListeners();
  }
}
