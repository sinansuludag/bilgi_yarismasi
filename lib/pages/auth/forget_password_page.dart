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
        appBar: AppBar(
            title: Text("Şifre sıfırlama"),
            centerTitle: true,
            backgroundColor: Colors.indigo.shade300),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Şifre sıfırlamak istediğin emailini gir :",
                style: TextStyle(color: Colors.indigo.shade300, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.email,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: forgetPasswordController,
                          decoration: InputDecoration(
                            hintText: "email",
                            border: UnderlineInputBorder(),
                          ),
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
                    color: Colors.indigo.shade300),
                child: MyTextButton(
                    onPressed: () async {
                      var forgetPassword =
                          forgetPasswordController.text.trim();
                      await authService.forgetPassword(forgetPassword);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(
                                "Şifre sıfırlama linki gönderildi,emailinizi kontrol ediniz",textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    backgroundColor: Colors.white,
                                    color: Colors.indigo.shade400),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Geri don"))
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
