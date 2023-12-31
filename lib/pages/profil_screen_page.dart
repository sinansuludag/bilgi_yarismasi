import 'dart:io';
import 'package:bilgi_barismasi/notifier_pages/profil_screen_page_notifier.dart';
import 'package:flutter/material.dart';
import 'package:bilgi_barismasi/service/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../service/remote_datasource.dart';
import '../service/riverpood_manager.dart';
import 'create_test_pages/add_picture_screen_page.dart';

class MyProfilScreenPage extends ConsumerStatefulWidget {
  const MyProfilScreenPage({Key? key}) : super(key: key);

  @override
  _MyProfilScreenPageState createState() => _MyProfilScreenPageState();
}

class _MyProfilScreenPageState extends ConsumerState<MyProfilScreenPage> {
  final authService = AuthService();
  final firebaseService = FirebaseService();
  late MyProfilScreenPageNotifier providerValue;
  String imageUrl='';

  @override
  void initState() {
    super.initState();
    providerValue = ref.read(myProfilScreenProvider);
    providerValue.getCurrentUserDataUpdate();
  }




  @override
  Widget build(BuildContext context) {
    providerValue = ref.watch(myProfilScreenProvider);
    String defaultImageUrl =
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
                authService.signOut();
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
                          child: providerValue.profileUrl !=''
                              ? Image.network(providerValue.profileUrl ,fit: BoxFit.cover,)
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(defaultImageUrl),
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
                               providerValue.uploadImage(result);
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
              myTextFormWidget("İsim", providerValue.nameText,
                  providerValue.nameEditController),
              myTextFormWidget("E-mail", providerValue.emailText,
                  providerValue.emailEditController),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  myOutlinedButton("İptal", () {
                    providerValue.resetUserData();
                  }, Colors.white, Colors.black87),
                  myOutlinedButton("Kaydet", () {
                    providerValue.getCurrentUserDataUpdate();
                  }, Colors.green, Colors.white),
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
      String labelText, String hintText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
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
