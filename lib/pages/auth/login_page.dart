import 'package:bilgi_barismasi/Widgets/text_button.dart';
import 'package:bilgi_barismasi/service/auth_service.dart';
import 'package:bilgi_barismasi/widgets/flutter_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/bottom_navigation_bar.dart';
import '../../widgets/divider.dart';
import '../../widgets/text_form_field.dart';
import '../../widgets/ıcon_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _State();
}

class _State extends State<LoginPage> {
  late String email, password;
  final formKey = GlobalKey<FormState>();

  final firebaseAuth = FirebaseAuth.instance;
  final authService = AuthService();
  late FlutterToast flutterToast;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade300,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  titleText(),
                  buildSizedBox(),
                  myTextFormFieldEmail(),
                  buildSizedBox(),
                  myTextFormFieldPassword(),
                  buildSizedBox(),
                  forgetPasswordButton(),
                  buildSizedBox(),
                  signInButton(),
                  buildSizedBox(),
                  signInAnonymous(context),
                  buildSizedBox(),
                  myDivider(),
                  buildSizedBox(),
                  myIconButton(),
                  buildSizedBox(),
                  signUpButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row myTextFormFieldPassword() {
    return Row(
      children: [
        const Icon(Icons.password),
        Expanded(
          child: MyTextFormField(
            hintText: "Sifre",
            onSaved: (value) {
              password = value!;
            },
            obscureText: true,
          ),
        ),
      ],
    );
  }

  Row myTextFormFieldEmail() {
    return Row(
      children: [
        const Icon(Icons.email),
        Expanded(
          child: MyTextFormField(
            hintText: "Email",
            onSaved: (value) {
              email = value!;
            },
          ),
        ),
      ],
    );
  }

  Container signInAnonymous(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(58), color: Colors.black26),
      child: MyTextButton(
        onPressed: () async {
          final result = await authService.signInAnonymous();
          if (result =="succes") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyBottomNavigationBar()
              ),
            );
          }
        },
        textButton: "Misafir Girişi",
        textColor: Colors.white,
      ),
    );
  }

  Row myIconButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyIconButton(
            onPressed: () async {
              await authService.signInWithFacebook();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyBottomNavigationBar()
                ),
              );
            },
            icon: Image.asset("assets/images/facebook.png"),
            iconSize: 40),
        MyIconButton(
            onPressed: () async {
              await authService.signInWithGoogle();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyBottomNavigationBar()
                ),
              );
            },
            icon: Image.asset("assets/images/google.png"),
            iconSize: 40),
      ],
    );
  }

  Row signUpButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Hesabın yok mu?",
          style: TextStyle(fontSize: 17),
        ),
        Container(
          height: MediaQuery.of(context).size.height * .20,
          child: MyTextButton(
            onPressed: () => Navigator.pushNamed(context, "/SignUpPage"),
            textButton: "Hesap Olustur",
            textColor: Colors.red.shade900,
          ),
        ),
      ],
    );
  }

  Container signInButton() {
    return Container(
      height: 50,
      width: 150,
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(58), color: Colors.black26),
      child: MyTextButton(onPressed: signIn, textButton: "Giris Yap"),
    );
  }

  MyDivider myDivider() {
    return  MyDivider(text: 'ya da',);
  }

  void signIn() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      formKey.currentState!.reset();
     var result=await authService.signIn(email, password);
      if(result=="succes"){
       Navigator.pushNamed(context, "/MyQuizLiveSessionScreenPage");
      }
    }
  }

  MyTextButton forgetPasswordButton() {
    return MyTextButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, "/ForgetPasswordPage");
      },
      textButton: "Sifremi Unuttum",
      textColor: Colors.red.shade900,
    );
  }

  Container titleText() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: const Text(
        "HOŞGELDİNİZ",
        style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontFamily: "DancingScript",
            fontWeight: FontWeight.bold),
      ),
    );
  }

  SizedBox buildSizedBox() {
    return const SizedBox(
      height: 5,
    );
  }

}
