import 'package:bilgi_barismasi/Widgets/text_button.dart';
import 'package:bilgi_barismasi/service/auth_service.dart';
import 'package:bilgi_barismasi/widgets/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/bottom_navigation_bar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _State();
}

class _State extends State<SignUpPage> {
  late String email, password, isim;

  final formKey = GlobalKey<FormState>();

  final firebaseAuth = FirebaseAuth.instance;
  final authService = AuthService();

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
                  myTextFormFieldName(),
                  myTextFormFieldEmail(),
                  myTextFormFieldPassword(),
                  buildSizedBox(),
                  signUpButton(),
                  buildSizedBox(),
                  signInButton(),
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

  Row myTextFormFieldName() {
    return Row(
      children: [
        const Icon(Icons.account_circle_sharp),
        Expanded(
          child: MyTextFormField(
            hintText: "İsim",
            onSaved: (value) {
              isim = value!;
            },
          ),
        ),
      ],
    );
  }

  Row signInButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Hesabın var mı?",
          style: TextStyle(fontSize: 17),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .20,
          child: MyTextButton(
            onPressed: () => Navigator.pushNamed(context, "/LoginPage"),
            textButton: "Giriş Yap",
            textColor: Colors.red.shade900,
          ),
        ),
      ],
    );
  }

  Container signUpButton() {
    return Container(
      height: 50,
      width: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(58), color: Colors.black26),
      margin: const EdgeInsets.only(top: 15),
      child: MyTextButton(
        onPressed: signUp,
        textButton: "Hesap Olustur",
      ),
    );
  }

  void signUp() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      formKey.currentState!.reset();
      var result = await authService.signUp(email, password);

      if (result == "succes") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.indigo.shade200,
            duration: const Duration(seconds: 3),
            content: Text("Hesap oluşturuldu",
                style: TextStyle(fontSize: 20, color: Colors.indigo.shade900),
                textAlign: TextAlign.center),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyBottomNavigationBar()
          ),
        );
      }
    }
  }

  Container titleText() {
    return Container(
      margin: const EdgeInsets.only(top: 50, bottom: 30),
      child: const Text(
        "HESAP OLUŞTURUN",
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
