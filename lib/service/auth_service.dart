import 'package:bilgi_barismasi/widgets/flutter_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final firebaseAuth = FirebaseAuth.instance;
  FlutterToast flutterToast = FlutterToast();

  late BuildContext context;

  void setContext(BuildContext ctx) {
    context = ctx;
  }

  Future signInAnonymous() async {
    String res;
    try {
      await firebaseAuth.signInAnonymously();
      res = "succes";
    } on FirebaseAuthException catch (e) {
      res = flutterToast.errorController(e);
    }
    return res;
  }

  Future signIn(String email, String password) async {
    String res = '';
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      res = "succes";
    } on FirebaseAuthException catch (e) {
      res = flutterToast.errorController(e);
    }
    return res;
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future signInWithFacebook() async {
    String? res;
    try {
      final facebookLogin = FacebookLogin();

      final result = await facebookLogin.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

      final accessToken = result.accessToken;

      if (accessToken != null) {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);

        await FirebaseAuth.instance.signInWithCredential(credential);
      }
      res = "succes";
    } on FirebaseAuthException catch (e) {
      res = flutterToast.errorController(e);
    }
    return res;
  }

  Future signUp(String email, String password) async {
    String res;
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      res = "succes";
    } on FirebaseAuthException catch (e) {
      res = flutterToast.errorController(e);
    }
    return res;
  }

  Future forgetPassword(String email) async {
    String res;
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      res = "succes";
    } on FirebaseAuthException catch (e) {
      res = flutterToast.errorController(e);
    }
    return res;
  }

  Future signOut() async {
    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      final facebookLogin = FacebookLogin();
      await facebookLogin.logOut();

      await firebaseAuth.signOut();
    } catch (e) {
      flutterToast.errorController(e);
    }
  }

  void showErrorDialog(String title, String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }
}
