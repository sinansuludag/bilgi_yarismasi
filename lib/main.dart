import 'package:bilgi_barismasi/Pages/Auth/login_page.dart';
import 'package:bilgi_barismasi/pages/create_test_pages/add_picture_screen_page.dart';
import 'package:bilgi_barismasi/pages/auth/sign_up_page.dart';
import 'package:bilgi_barismasi/pages/create_test_pages/create_quiz_shape_page.dart';
import 'package:bilgi_barismasi/pages/create_test_pages/create_screen_page.dart';
import 'package:bilgi_barismasi/pages/auth/forget_password_page.dart';
import 'package:bilgi_barismasi/pages/home_page.dart';
import 'package:bilgi_barismasi/pages/profil_screen_page.dart';
import 'package:bilgi_barismasi/pages/test_live_pages/test_live_session_screen_page.dart';
import 'package:bilgi_barismasi/widgets/bottom_navigation_bar.dart';
import 'package:bilgi_barismasi/widgets/text_field.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
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
        "/HomePage": (context) => const HomePage(),
        "/LoginPage": (context) => const LoginPage(),
        "/SignUpPage": (context) => const SignUpPage(),
        "/ForgetPasswordPage": (context) => const ForgetPasswordPage(),
        "/MyCreateScreenPage": (context) => const MyCreateScreenPage(),
        "/MyProfilScreenPage": (context) => const MyProfilScreenPage(),
        "/MyBottomNavigationBar": (context) => const MyBottomNavigationBar(),
        "/AddPictureScreenPage": (context) => const AddPictureScreenPage(),
        "/MyQuizShapePage": (context) => const MyQuizShapePage(isItQuiz: true),
        // "/MyDogruYanlisShapePage": (context) => const MyDogruYanlisShapePage(),
        "/MyTextFieldPage": (context) => const MyTextFieldPage(),
        "/MyQuizLiveSessionScreenPage": (context) =>
            const MyLiveTestSessionScreenPage(testId: ""),
      },
      home: const Scaffold(
        body: LoginPage(),
      ),
    );
  }
}
