import 'package:bilgi_barismasi/pages/create_test_pages/create_quiz_shape_page.dart';
import 'package:flutter/material.dart';

class questionShapeChose extends StatelessWidget {
  const questionShapeChose({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showBottomSheet(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo.shade100,
        minimumSize: const Size(115, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        "Soru ekle",
        style: TextStyle(fontSize: 15, color: Colors.indigo.shade700),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.indigo.shade200,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      context: context,
      builder: (context) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.60,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.cancel_outlined,
                        size: 30, color: Colors.black),
                  ),
                  title: Container(
                      margin: const EdgeInsets.only(left: 60),
                      child: Text(
                        "Soru ekle",
                        style: TextStyle(
                            color: Colors.indigo.shade900,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                const SizedBox(
                  height: 5,
                ),
                const ListTile(
                  title: Text("Bilgi düzeyini test et",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    myQuizButton(
                      "assets/images/options_6193980.png",
                      "Quiz",
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyQuizShapePage(
                                      isItQuiz: true,
                                    )));
                      },
                    ),
                    myQuizButton(
                      "assets/images/answer_3261305.png",
                      "Doğru-Yanlış",
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyQuizShapePage(
                                      isItQuiz: false,
                                    )));
                      },
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }

  TextButton myQuizButton(String asset, String text, VoidCallback fonk) {
    return TextButton(
      onPressed: () {
        fonk();
      },
      child: Container(
        height: 140,
        width: 160,
        color: Colors.indigo.shade100,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 20, top: 12),
                  height: 75,
                  width: 75,
                  child: Image.asset(asset)),
              Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Text(text,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.indigo.shade500,
                          fontWeight: FontWeight.bold))),
            ],
          ),
        ),
      ),
    );
  }
}
