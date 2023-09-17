import 'package:bilgi_barismasi/Model/questions_model.dart';
import 'package:bilgi_barismasi/service/remote_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePageNotifier extends ChangeNotifier {
  List<TestModel?>? tests;
  List<String>? testIds;

  void getTestDatas() async {
    FirebaseService service = FirebaseService();

    tests = await service.getAllTestsFromFirestore();
    testIds = await service.getTestDocumentIds();

    notifyListeners();
  }

  Future<bool> deleteTest(int index) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      if (tests![index]!.userId == userId) {
        await FirebaseService().deleteTestDocument(testIds![index]);
        testIds!.removeAt(index);
        tests!.removeAt(index);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print("Silme hatası: $e");
      return false;
    }
  }

}
