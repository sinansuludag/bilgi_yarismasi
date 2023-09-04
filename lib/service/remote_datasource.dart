import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference tests =
      FirebaseFirestore.instance.collection('Tests');

  void getAllTests() async {
    QuerySnapshot querySnapshot = await tests.get();
    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      print(document.id);
    }
  }
}
