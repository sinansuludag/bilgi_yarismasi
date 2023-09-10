import 'dart:io';
import 'package:bilgi_barismasi/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'create_test_pages/add_picture_screen_page.dart';

class MyProfilScreenPage extends StatefulWidget {
  const MyProfilScreenPage({Key? key}) : super(key: key);

  @override
  _MyProfilScreenPageState createState() => _MyProfilScreenPageState();
}

class _MyProfilScreenPageState extends State<MyProfilScreenPage> {
  final authServise = AuthService();
  bool showPassword = false;
  File? photoFile;

  @override
  Widget build(BuildContext context) {
    String imageUrl =
        "https://media.istockphoto.com/id/1214428300/tr/vekt%C3%B6r/varsay%C"
        "4%B1lan-"
        "profil-resmi-avatar-foto%C4%9Fraf-yer-tutucusu-vekt%C3%B6r-%C3%A7izimi.jpg?s=170667a&w=0&"
        "k=20&c=jX-CaCRoEt40rQ3FrizeSA98Lh34MBcphiFZyJz_rJo=";

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo.shade300,
        appBar: AppBar(
          backgroundColor: Colors.indigo.shade300,
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
              onPressed: () {
                authServise.signOut();
                Navigator.pushNamed(context, "/LoginPage");
              },
              child: const Text(
                "Çıkış yap",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 0.5,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: photoFile != null
                              ? Image.file(
                            File(photoFile!.path),
                            fit: BoxFit.cover,
                          )
                              : CircleAvatar(
                            backgroundImage: NetworkImage(imageUrl),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.lightGreenAccent,
                            border: Border.all(
                              width: 2,
                              color: Colors.black87,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.black87,
                            ),
                            onPressed: () async {
                              File? result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const AddPictureScreenPage(),
                                ),
                              );

                              if (result != null) {
                                setState(() {
                                  photoFile = result;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              myTextFormWidget("İsim", "Ahmet", false),
              myTextFormWidget("E-mail", "ahmet.123@gmail.com", false),
              myTextFormWidget("Şifre", "*********", true),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  myOutlinedButton("İptal", () {}, Colors.white, Colors.black87),
                  myOutlinedButton("Kaydet", () {}, Colors.green, Colors.white),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  OutlinedButton myOutlinedButton(
      String text, Function function, Color color, Color textColor) {
    return OutlinedButton(
      onPressed: () => function(),
      style: OutlinedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(160, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 14, color: textColor, letterSpacing: 2),
      ),
    );
  }

  Padding myTextFormWidget(
      String labelText, String hintText, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            icon: const Icon(Icons.remove_red_eye),
          )
              : null,
          contentPadding: const EdgeInsets.only(bottom: 3),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: labelText,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
