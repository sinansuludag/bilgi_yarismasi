import 'package:bilgi_barismasi/Pages/Auth/login_page.dart';
import 'package:bilgi_barismasi/pages/add_picture_screen_page.dart';
import 'package:bilgi_barismasi/pages/auth/sign_up_page.dart';
import 'package:bilgi_barismasi/pages/create_dogruyanlis_shape_page.dart';
import 'package:bilgi_barismasi/pages/create_quiz_shape_page.dart';
import 'package:bilgi_barismasi/pages/create_screen_page.dart';
import 'package:bilgi_barismasi/pages/forget_password_page.dart';
import 'package:bilgi_barismasi/pages/home_page.dart';
import 'package:bilgi_barismasi/pages/profil_screen_page.dart';
import 'package:bilgi_barismasi/widgets/bottom_navigation_bar.dart';
import 'package:bilgi_barismasi/widgets/text_field.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/HomePage": (context) => HomePage(),
        "/LoginPage": (context) => LoginPage(),
        "/SignUpPage": (context) => SignUpPage(),
        "/ForgetPasswordPage":(context) => ForgetPasswordPage(),
        "/MyCreateScreenPage":(context) =>MyCreateScreenPage(),
        "/MyProfilScreenPage":(context) => MyProfilScreenPage(),
        "/MyBottomNavigationBar":(context) => MyBottomNavigationBar(),
        "/AddPictureScreenPage" :(context) => AddPictureScreenPage(),
        "/MyQuizShapePage":(context) =>MyQuizShapePage(),
        "/MyDogruYanlisShapePage":(context) => MyDogruYanlisShapePage(),
        "/MyTextFieldPage":(context) => MyTextFieldPage(),
      },
      home: Scaffold(
        body: LoginPage(),
      ),
    );
  }
}
