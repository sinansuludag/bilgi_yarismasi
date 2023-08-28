import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/bottom_navigation_bar.dart';
import '../widgets/questionShapeChose.dart';
import 'add_picture_screen_page.dart';

class MyCreateScreenPage extends StatefulWidget {
  const MyCreateScreenPage({Key? key}) : super(key: key);

  @override
  State<MyCreateScreenPage> createState() => _MyCreateScreenPageState();
}

class _MyCreateScreenPageState extends State<MyCreateScreenPage> {
  File? secilenDosya;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo.shade300,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.indigo.shade200,
          title: myAppbarButtons(),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              myPictureContainer(),
              SizedBox(
                height: 5,
              ),
              myTitle("Başlık"),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: myTextFormField(),
                  ))
                ],
              ),
              SizedBox(
                height: 8,
              ),
              myTitle("Sorular (1)"),
              SizedBox(
                height: 8,
              ),
              questionShapeChose(),
            ],
          ),
        ),
      ),
    );
  }

  Row myAppbarButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: ()=> Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyBottomNavigationBar()
            ),
          ),
          child: Text(
            "İptal",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Text(
          "Quiz Oluştur",
          style: TextStyle(
            color: Colors.indigo.shade900,
            fontWeight: FontWeight.bold,
            fontSize: 35,
            fontFamily: "DancingScript",
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "Kaydet",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Padding myPictureContainer() {
    return Padding(
      padding: const EdgeInsets.only(right: 5, left: 5, top: 5),
      child: TextButton(
        onPressed: () async {
          File result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPictureScreenPage()),
          );

         print(result);
          if (result != null) {
            setState(() {
              secilenDosya = result;
            });
          }
        },
        child: Container(
          height: 250,
          width: double.infinity,
          color: Colors.indigo.shade100,
          child: Center(
            child: secilenDosya != null
                ? Image.file(
              File(secilenDosya!.path),
              fit: BoxFit.cover,
            )
                :Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 35,
                  width: 35,
                  child: Image.asset("assets/images/icons8-gallery-64.png"),
                ),
                SizedBox(height: 5),
                Text(
                  "Kapak resmi eklemek için dokun",
                  style: TextStyle(color: Colors.indigo.shade700),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding myTitle(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
        textAlign: TextAlign.start,
      ),
    );
  }

  TextFormField myTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
          hintText: "Başlığı gir",
          filled: true,
          fillColor: Colors.indigo.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.indigo.shade900,
          ))),
    );
  }
}



