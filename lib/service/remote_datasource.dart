import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import '../Model/questions_model.dart';

class FirebaseService {

  Future<String?> getImageUrlForQuestion() async {
    try {
      CollectionReference questionsCollection =
      FirebaseFirestore.instance.collection('Questions');

      QuerySnapshot questionQuerySnapshot = await questionsCollection.get();

      if (questionQuerySnapshot.docs.isNotEmpty) {
        // İlk belgeyi alın (Varsayılan olarak otomatik olarak atanan ID'ye sahip)
        QueryDocumentSnapshot questionDocument = questionQuerySnapshot.docs.first;

        Map<String, dynamic> questionData =
        questionDocument.data() as Map<String, dynamic>;

        // Sorunun resmi URL'sini alın
        String imageUrl = questionData['imageUrl'];

        return imageUrl;
      } else {
        print('Hiç soru belgesi bulunamadı.');
        return null;
      }
    } catch (e) {
      print('Sorunun resmini çekerken bir hata oluştu: $e');
      return null;
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

  Future<List<String>> getTestDocumentIds() async {
    try {
      // Firebase Firestore bağlantısını oluşturun
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // "Tests" koleksiyonuna referans alın
      CollectionReference testsCollection = firestore.collection('Tests');

      // Koleksiyon içindeki dokümanları alın
      QuerySnapshot querySnapshot = await testsCollection.get();

      // Doküman ID'lerini içeren bir liste oluşturun
      List<String> documentIds = [];

      // Her dokümanın ID'sini listeye ekleyin
      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        documentIds.add(document.id);
      }

      return documentIds;
    } catch (e) {
      print("Doküman ID'leri alınırken bir hata oluştu: $e");
      return []; // Hata durumunda boş bir liste döndürülebilir veya hata yönetimi yapılabilir.
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

  Stream<DocumentSnapshot<Map<String, dynamic>>> listenToDocument(
      String testId) {
    return FirebaseFirestore.instance
        .collection('Tests')
        .doc(testId)
        .snapshots();
  }
}
