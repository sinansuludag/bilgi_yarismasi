import 'package:bilgi_barismasi/Widgets/text_button.dart';
import 'package:bilgi_barismasi/service/auth_service.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController forgetPasswordController = TextEditingController();
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo.shade300,
        appBar: AppBar(
            title: Text("Şifre sıfırlama"),
            centerTitle: true,
            backgroundColor: Colors.indigo.shade200),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Şifre sıfırlamak istediğin emailini gir :",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: forgetPasswordController,
                          decoration: InputDecoration(
                            hintText: "email",
                            hintStyle: TextStyle(color: Colors.white),
                            border: UnderlineInputBorder(),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(58),
                    color: Colors.indigo.shade900),
                child: MyTextButton(
                    onPressed: () async {
                      var forgetPassword = forgetPasswordController.text.trim();
                      await authService.forgetPassword(forgetPassword);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              content: Text(
                                "Şifre sıfırlama linki gönderildi,emailinizi kontrol ediniz",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.indigo.shade500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      "Geri don",
                                      style: TextStyle(
                                          color: Colors.indigo.shade500,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ))
                              ],
                            );
                          });
                    },
                    textButton: "Sıfırla",
                    textColor: Colors.white,
                    textSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
