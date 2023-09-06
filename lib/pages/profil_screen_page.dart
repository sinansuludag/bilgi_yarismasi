import 'package:bilgi_barismasi/service/auth_service.dart';
import 'package:flutter/material.dart';

class MyProfilScreenPage extends StatefulWidget {
  const MyProfilScreenPage({Key? key}) : super(key: key);

  @override
  State<MyProfilScreenPage> createState() => _MyProfilScreenPageState();
}

class _MyProfilScreenPageState extends State<MyProfilScreenPage> {
  final authServise=AuthService();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.indigo.shade300,
          appBar: AppBar(
            backgroundColor: Colors.indigo.shade300,
            automaticallyImplyLeading: false,
            actions: [
              TextButton(onPressed:(){authServise.signOut();
                Navigator.pushNamed(context, "/LoginPage");
                }, child: Text("Çıkış yap",style: TextStyle(color: Colors.white,letterSpacing: 0.5,fontSize: 14,fontWeight: FontWeight.bold),))
            ],
          ),
          body: Container(
            child: GestureDetector(
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
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4, color: Colors.indigo.shade300),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.7),
                                  offset: Offset(0, 7),
                                )
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://media.istockphoto.com/id/1214428300/tr/vekt%C3%B6r/varsay%C4%B1lan-profil-resmi-avatar-foto%C4%9Fraf-yer-tutucusu-vekt%C3%B6r-%C3%A7izimi.jpg?s=170667a&w=0&k=20&c=jX-CaCRoEt40rQ3FrizeSA98Lh34MBcphiFZyJz_rJo="),
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
                                      width: 2, color: Colors.black87)),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.edit, color: Colors.black87),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  myTextFormWidget("İsim", "Zeynep", false),
                  myTextFormWidget("E-mail", "zeynep.123@gmail.com", false),
                  myTextFormWidget("Şifre", "*********", true),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      myOutlinedButton("İptal",(){},Colors.white,Colors.black87),
                      myOutlinedButton("Kaydet",(){},Colors.green,Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  OutlinedButton myOutlinedButton(String text,Function function,Color color,Color textColor) {
    return OutlinedButton(
                      onPressed: ()=> function(),
                      child: Text(
                        text,
                        style: TextStyle(
                            fontSize: 14,
                            color: textColor,
                            letterSpacing: 2),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: color,
                        minimumSize: Size(160, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
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
                  icon: Icon(Icons.remove_red_eye))
              : null,
          contentPadding: EdgeInsets.only(bottom: 3),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
    );
  }
}
