import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo.shade300,
        appBar: AppBar(
          title: Text(
            "Soru Kitapçıklarım",
            style: TextStyle(
              fontFamily: "DancingScript",
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: Colors.indigo.shade900
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.indigo.shade200,
        ),
      ),
    );
  }
}
