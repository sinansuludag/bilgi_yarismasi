import 'package:bilgi_barismasi/Model/questions_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../service/remote_datasource.dart';

class MyLiveSessionQuizShapeNotifier extends ChangeNotifier {
  late TestModel test;
  late String testId;
  @override
  void initState(String testID) {
    testId = testID;
    print("aaaa$testId");
    final AutoDisposeStreamProvider<DocumentSnapshot<Object?>>
        documentStreamProvider = StreamProvider.autoDispose<DocumentSnapshot>(
      (ref) => FirebaseService().listenToDocument(testId),
    );

    final documentSnapshot = ProviderContainer().read(documentStreamProvider);

    if (documentSnapshot.asData != null) {
      final data = documentSnapshot.asData as Map<String, dynamic>;
      print(data);
    } else {
      print('Belge verisi yok veya null.');
    }
  }

  List<Color> borderColors = [
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
  ];

  void changeActivePassive(int index) {
    for (int i = 0; i < borderColors.length; i++) {
      borderColors[i] = Colors.transparent;
    }

    if (index == 0) {
      borderColors[0] = Colors.white;
    } else if (index == 1) {
      borderColors[1] = Colors.white;
    } else if (index == 2) {
      borderColors[2] = Colors.white;
    } else if (index == 3) {
      borderColors[3] = Colors.white;
    }

    notifyListeners();
  }

  List<Color> dyBorderColors = [
    Colors.transparent,
    Colors.transparent,
  ];

  void dyChangeActivePassive(int index) {
    for (int i = 0; i < dyBorderColors.length; i++) {
      dyBorderColors[i] = Colors.transparent;
    }

    if (index == 0) {
      dyBorderColors[0] = Colors.white;
    } else if (index == 1) {
      dyBorderColors[1] = Colors.white;
    }

    notifyListeners();
  }
}
