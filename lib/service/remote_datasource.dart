import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import '../Model/questions_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  Future<void> deleteDocument(String collectionName, String documentId) async {
    try {
      CollectionReference collection = FirebaseFirestore.instance.collection(collectionName);

      // Belgeyi sil
      await collection.doc(documentId).delete();
      print('Belge başarıyla silindi.');
    } catch (e) {
      print('Belge silme hatası: $e');
    }
  }

  Future<String?> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      // Benzersiz bir kimlik oluştur
      var uuid = const Uuid();
      String uniqueId = uuid.v4();

      // Resmi Firebase Storage'a yükleme
      TaskSnapshot taskSnapshot = await FirebaseStorage.instance
          .ref('images/$uniqueId.png') // Yüklenecek resmin depolama yolu
          .putFile(imageFile);

      // Yükleme tamamlandığında resmin indirme URL'sini al
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print("Hata: $e");
      return null;
    }
  }

  Future<void> saveUserUIDToFirestore() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      String? email = FirebaseAuth.instance.currentUser!.email;

      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('Users');

      await usersCollection.doc(uid).set({'uid': uid, 'email': email});

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

  Future<void> setActiveStatus(String documentId) async {
    try {
      await _firestore.collection('Tests').doc(documentId).update({
        'isActive': true,
      });
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  Future<List<String>> getTestDocumentIds() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference testsCollection = firestore.collection('Tests');
      QuerySnapshot querySnapshot = await testsCollection.get();
      List<String> documentIds = [];

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        documentIds.add(document.id);
      }

      return documentIds;
    } catch (e) {
      print("Doküman ID'leri alınırken bir hata oluştu: $e");
      return [];
    }
  }

  Future<void> addTestToFirestore(TestModel test) async {
    try {
      List<QuestionModel> questionList = List.from(test.questions);

      CollectionReference testCollection =
          FirebaseFirestore.instance.collection('Tests');

      Map<String, dynamic> testJson = test.toJson();

      DocumentReference newDocumentReference =
          await testCollection.add(testJson);

      CollectionReference questionsCollection =
          newDocumentReference.collection('Questions');

      for (QuestionModel question in questionList) {
        Map<String, dynamic> questionJson = question.toJson();
        await questionsCollection.add(questionJson);
      }

      print('Test ve soruları başarıyla Firestore\'a eklendi');
    } catch (e) {
      print('Firestore veri ekleme hatası: $e');
    }
  }

  Future<void> deleteUserAtIndexFromTest(
      String testId, int indexToRemove) async {
    try {
      // Firestore referansını al
      final DocumentReference<Map<String, dynamic>> testRef =
          FirebaseFirestore.instance.collection('Tests').doc(testId);

      // Belgeyi getir
      final DocumentSnapshot<Map<String, dynamic>> testSnapshot =
          await testRef.get();

      if (testSnapshot.exists) {
        // Belge varsa, var olan verileri al
        final List<String> existingUserNames =
            List<String>.from(testSnapshot.data()?['userNames'] ?? []);
        final List<int> existingUserScores =
            List<int>.from(testSnapshot.data()?['userScores'] ?? []);

        // İstenen indeksi silebilirsiniz
        if (indexToRemove >= 0 &&
            indexToRemove < existingUserNames.length &&
            indexToRemove < existingUserScores.length) {
          existingUserNames.removeAt(indexToRemove);
          existingUserScores.removeAt(indexToRemove);

          // Güncellenmiş verileri hazırla
          final Map<String, dynamic> updatedData = {
            'userNames': existingUserNames,
            'userScores': existingUserScores,
          };

          // Belgeyi güncelle
          await testRef.update(updatedData);

          print('Kullanıcı başarıyla test belgesinden silindi.');
        } else {
          print('Geçersiz indeks: $indexToRemove');
        }
      } else {
        print('Belge bulunamadı.');
      }
    } catch (e) {
      print('Firestore veri güncelleme hatası: $e');
    }
  }

  Future<void> updateQuestionIndex(String testId, int newIndex) async {
    try {
      final DocumentReference<Map<String, dynamic>> testRef =
          FirebaseFirestore.instance.collection('Tests').doc(testId);

      final DocumentSnapshot<Map<String, dynamic>> testSnapshot =
          await testRef.get();

      if (testSnapshot.exists) {
        // Belge varsa, yeni indeksi güncelle
        final Map<String, dynamic> updatedData = {
          'questionIndex': newIndex,
        };

        // Belgeyi güncelle
        await testRef.update(updatedData);

        print('questionIndex başarıyla güncellendi.');
      } else {
        print('Belge bulunamadı.');
      }
    } catch (e) {
      print('Firestore veri güncelleme hatası: $e');
    }
  }

  Future<void> updateUserScoreAtIndex(
      String testId, int indexToUpdate, int newScore) async {
    try {
      final DocumentReference<Map<String, dynamic>> testRef =
          FirebaseFirestore.instance.collection('Tests').doc(testId);

      final DocumentSnapshot<Map<String, dynamic>> testSnapshot =
          await testRef.get();

      if (testSnapshot.exists) {
        final List<int> existingUserScores =
            List<int>.from(testSnapshot.data()?['userScores'] ?? []);
        if (indexToUpdate >= 0 && indexToUpdate < existingUserScores.length) {
          existingUserScores[indexToUpdate] = newScore;

          final Map<String, dynamic> updatedData = {
            'userScores': existingUserScores,
          };

          // Belgeyi güncelle
          await testRef.update(updatedData);

          print('Kullanıcı puanı başarıyla güncellendi.');
        } else {
          print('Geçersiz indeks: $indexToUpdate');
        }
      } else {
        print('Belge bulunamadı.');
      }
    } catch (e) {
      print('Firestore veri güncelleme hatası: $e');
    }
  }

  Future<int> addUserToTest(
      String testId, String userName, int userScore) async {
    try {
      final DocumentReference<Map<String, dynamic>> testRef =
          FirebaseFirestore.instance.collection('Tests').doc(testId);

      final DocumentSnapshot<Map<String, dynamic>> testSnapshot =
          await testRef.get();

      if (testSnapshot.exists) {
        final List<String> existingUserNames =
            List<String>.from(testSnapshot.data()?['userNames'] ?? []);
        final List<int> existingUserScores =
            List<int>.from(testSnapshot.data()?['userScores'] ?? []);

        existingUserNames.add(userName);
        existingUserScores.add(userScore);

        final Map<String, dynamic> updatedData = {
          'userNames': existingUserNames,
          'userScores': existingUserScores,
        };

        print('Kullanıcı başarıyla test belgesine eklendi.');
        await testRef.update(updatedData);
        return (existingUserNames.length - 1);
      } else {
        print('Belge bulunamadı.');
      }
    } catch (e) {
      print('Firestore veri güncelleme hatası: $e');
    }
    return -1;
  }

  Future<String> getUserName(String uid) async {
    try {
      final DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        return data['name'];
      } else {
        return 'Kullanıcı bulunamadı';
      }
    } catch (e) {
      print('Kullanıcı adı çekme hatası: $e');
      return 'Hata oluştu';
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> listenToDocument(
      String testId) {
    return FirebaseFirestore.instance
        .collection('Tests')
        .doc(testId)
        .snapshots();
  }
}
