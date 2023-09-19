import 'dart:io';

import 'package:bilgi_barismasi/service/remote_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class MyProfilScreenPageNotifier extends ChangeNotifier {
   TextEditingController nameEditController = TextEditingController();
   TextEditingController emailEditController = TextEditingController();

   FirebaseService firebaseService = FirebaseService();
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   final FirebaseAuth _auth = FirebaseAuth.instance;
   Map<String, dynamic>? userdata; // userdata haritasını nullable olarak tanımlayın
    String nameText='';
    String emailText='';
   File? profileImage;
   String? profileUrl;

 Future<void> getCurrentUserDataUpdate() async {
    userdata=await firebaseService.getCurrentUserDataFromFirestore();
      nameText=userdata!["name"] ?? '';
     emailText=userdata!["email"] ?? '';
    profileUrl=userdata!["profileImageUrl"] ?? '';

    if(nameEditController.text!='' && nameEditController!=nameText){
       nameText=nameEditController.text;
       firebaseService.saveUserNameToFirestore(nameText);
    }
    if(emailEditController.text!='' && emailEditController!=emailText){
       emailText=emailEditController.text;
       firebaseService.saveUserUIDToFirestore();
    }
    notifyListeners();
 }

  Future<void> updateProfileImageToFirestore() async {
   await firebaseService.updateUserProfileImage(profileUrl!);
  }


 Future<void> resetUserData() async {
    userdata=await firebaseService.getCurrentUserDataFromFirestore();
     nameText=userdata!["name"] ?? '';
     emailText=userdata!["email"] ?? '';
    profileUrl=userdata!["profileImageUrl"] ?? '';
    nameEditController.text='';
    emailEditController.text='';

    notifyListeners();
 }

   Future<void> uploadImage(File imageFile) async {
     try {
       String? imageUrl = await uploadImageToFirebaseStorage(imageFile);

       if (imageUrl != null) {
         profileImage = imageFile;
         profileUrl = imageUrl;
         updateProfileImageToFirestore();
         notifyListeners();
       }
     } catch (e) {
       print("Hata: $e");
     }
   }

   /*Future<String?> getUserProfileImageUrl() async {
     try {
       // Kullanıcının kimlik doğrulamasını kontrol edin
       User? user = _auth.currentUser;
       if (user == null) {
         return null;
       }

       // Kullanıcının UID'sini alın
       String userUID = user.uid;

       // Firestore'dan kullanıcı belgesini alın veya sorgulayın
       DocumentSnapshot<Map<String, dynamic>> userDoc =
       await _firestore.collection('Users').doc(userUID).get();

       // Belgeye eriştikten sonra profil resmi URL'sini alabilirsiniz
       if (userDoc.exists) {
         Map<String, dynamic> userData = userDoc.data() ?? {};
         String profileImageUrl = userData['profileImageUrl'] ?? '';
         return profileImageUrl;
       } else {
         return null; // Kullanıcı belgesi bulunamadı
       }
     } catch (e) {
       print('Hata: $e');
       return null;
     }
   }*/

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

   notifyListeners();
}
