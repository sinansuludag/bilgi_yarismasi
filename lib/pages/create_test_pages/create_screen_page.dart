import 'dart:io';

import 'package:bilgi_barismasi/Model/questions_model.dart';
import 'package:bilgi_barismasi/notifier_pages/create_quiz_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../service/riverpood_manager.dart';
import '../../widgets/bottom_navigation_bar.dart';
import 'add_picture_screen_page.dart';
import 'create_quiz_shape_page.dart';

class MyCreateScreenPage extends ConsumerStatefulWidget {
  const MyCreateScreenPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MyCreateScreenPageState();
}

class _MyCreateScreenPageState extends ConsumerState<MyCreateScreenPage> {
  late CreateQuizNotifier providerValue;

  @override
  Widget build(BuildContext context) {
    providerValue = ref.watch(myQuizCreateProvider);

    return Stack(
      children: [
        SafeArea(
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
                  const SizedBox(
                    height: 5,
                  ),
                  myTitle("Başlık"),
                  const SizedBox(
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
                  const SizedBox(
                    height: 8,
                  ),
                  myTitle(
                      "Sorular (${(providerValue.questions.length).toString()})"),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: providerValue.questions.length,
                    itemBuilder: (context, index) => Card(
                        color: Colors.indigo.shade100,
                        child: Text(providerValue.questions[index].question)),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 10,
          child: ElevatedButton(
            onPressed: () {
              _showBottomSheet(context);
            },
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
          ),
        ),
      ],
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
                      () async {
                        Navigator.push<List<QuestionModel>>(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const MyQuizShapePage(isItQuiz: true),
                          ),
                        ).then((result) {
                          if (result != null) {
                            providerValue.addQuestions(result);
                          }
                        });
                      },

                    ),
                    myQuizButton(
                      "assets/images/answer_3261305.png",
                      "Doğru-Yanlış",
                      () async {
                        Navigator.push<List<QuestionModel>>(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const MyQuizShapePage(isItQuiz: false),
                          ),
                        ).then((result) {
                          if (result != null) {
                            providerValue.addQuestions(result);
                          }
                        });
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

  Row myAppbarButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MyBottomNavigationBar()),
          ),
          child: const Text(
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
          onPressed: () {
            providerValue.save();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MyBottomNavigationBar()),
            );
          },
          child: const Text(
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
      child: GestureDetector(
        onTap: () async {
          File? result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddPictureScreenPage(),
            ),
          );

          if (result != null) {
            await providerValue.uploadCoverImage(result);
          }
        },
        child: Container(
          height: 250,
          width: double.infinity,
          color: Colors.indigo.shade100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (providerValue.coverImage != null)
                Image.file(
                  File(providerValue.coverImage!.path),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              if (providerValue.coverImage == null)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 35,
                      width: 35,
                      child: Image.asset("assets/images/icons8-gallery-64.png"),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Kapak resmi eklemek için dokun",
                      style: TextStyle(color: Colors.indigo.shade700),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }


  Padding myTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
        textAlign: TextAlign.start,
      ),
    );
  }

  TextFormField myTextFormField() {
    return TextFormField(
      controller: providerValue.testNameController,
      decoration: InputDecoration(
          hintText: "Başlığı gir",
          filled: true,
          fillColor: Colors.indigo.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
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
