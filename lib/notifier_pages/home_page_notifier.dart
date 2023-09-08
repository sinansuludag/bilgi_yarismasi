import 'package:bilgi_barismasi/Model/questions_model.dart';
import 'package:bilgi_barismasi/service/remote_datasource.dart';
import 'package:flutter/material.dart';

class HomePageNotifier extends ChangeNotifier {
  List<TestModel?>? tests;

  void getTestDatas() async {
    FirebaseService service = FirebaseService();

    tests = await service.getAllTestsFromFirestore();
    notifyListeners();
  }
}
