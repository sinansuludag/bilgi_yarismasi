import 'package:flutter/material.dart';

class MyProfilScreenPage extends StatefulWidget {
  const MyProfilScreenPage({Key? key}) : super(key: key);

  @override
  State<MyProfilScreenPage> createState() => _MyProfilScreenPageState();
}

class _MyProfilScreenPageState extends State<MyProfilScreenPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo.shade300,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [Text("Profil",style: TextStyle(fontSize: 25),textAlign: TextAlign.center,)],
            ),
          ),
        ),
      ),
    );
  }
}
