import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../Model/questions_model.dart';

class FirebaseService {

  Future<void> saveUserUIDToFirestore() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      String? email=FirebaseAuth.instance.currentUser!.email;

      CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');


      await usersCollection.doc(uid).set({'uid': uid,'email':email});


      print('Kullanıcının UID\'si Firestore\'a kaydedildi');
    } catch (e) {
      print('Firestore veri ekleme hatası: $e');
    }
  }

  Future<void> saveUserNameToFirestore(String name) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');


      await usersCollection.doc(uid).update({'name': name});

      print('Kullanıcının adı Firestore\'a kaydedildi');
    } catch (e) {
      print('Firestore veri güncelleme hatası: $e');
    }
  }


  Future<Map<String, dynamic>> getCurrentUserDataFromFirestore() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;

      if (uid != null) {
        DocumentSnapshot userDocument =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();

        if (userDocument.exists) {
          Map<String, dynamic> userData =
          userDocument.data() as Map<String, dynamic>;
          return userData;
        } else {
          print('Kullanıcı verisi bulunamadı.');
          return {};
        }
      } else {
        print('Oturum açmış bir kullanıcı bulunamadı.');
        return {};
      }
    } catch (e) {
      print('Firestore veri çekme hatası: $e');
      return {};
    }
  }


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
