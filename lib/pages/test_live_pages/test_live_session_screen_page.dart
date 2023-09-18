import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:bilgi_barismasi/notifier_pages/live_session_quiz_shape_notifier.dart';
import 'package:bilgi_barismasi/service/riverpood_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/bottom_navigation_bar.dart';
import '../../widgets/live_session_dogruyanlis_answer_box.dart';
import '../../widgets/live_session_quiz_answer_box.dart';

//artik bu sayfadan hem dogru yanlis sorulari hemde quix sorulari goruntulenebiliyor
class MyLiveTestSessionScreenPage extends ConsumerStatefulWidget {
  const MyLiveTestSessionScreenPage({super.key, required this.testId});
  final String testId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MyLiveTestSessionScreenPageState();
}

class _MyLiveTestSessionScreenPageState
    extends ConsumerState<MyLiveTestSessionScreenPage> with AfterLayoutMixin {
  late MyLiveSessionQuizShapeNotifier providerValue;
  double lineWidth = 300;

  @override
  void initState() {
    super.initState();
    ref.read(myLiveSessionQuizShapeProvider);
    lineWidth = 300;
  }

  @override
  Widget build(BuildContext context) {
    providerValue = ref.watch(myLiveSessionQuizShapeProvider);

    return SafeArea(
        child: providerValue.isActive
            ? Scaffold(
                backgroundColor: Colors.indigo.shade300,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.indigo.shade200,
                  actions: [myActions(context)],
                ),
                body: providerValue.test == null
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Colors.black,
                      ))
                    : providerValue.isTable
                        ? Center(
                            child: ListView.builder(
                            itemCount: providerValue.userNames.length,
                            itemBuilder: (context, index) {
                              var list = providerValue.sortUsers();
                              return myListTile(index + 1, list[index]["name"],
                                  list[index]["score"]);
                            },
                          ))
                        : Center(
                            child: ListView(children: [
                              Column(
                                children: [
                                  myLiveSessionPicture(),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.indigo.shade200,
                                      ),
                                      height: 85,
                                      width: double.infinity,
                                      child: Center(
                                          child: Text(
                                        providerValue
                                            .test!
                                            .questions[
                                                providerValue.questionIndex]
                                            .question,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      )),
                                    ),
                                  ),
                                  providerValue
                                          .test!
                                          .questions[
                                              providerValue.questionIndex]
                                          .isItQuiz
                                      ? Column(
                                          children: [
                                            LiveSessionQuizAnswerBox(
                                              color1: Colors.amber,
                                              text1: providerValue
                                                  .test!
                                                  .questions[providerValue
                                                      .questionIndex]
                                                  .answers[0],
                                              changeBorder: providerValue
                                                  .changeActivePassive,
                                              color2: Colors.blue.shade500,
                                              borderColor1:
                                                  providerValue.borderColors[0],
                                              borderColor2:
                                                  providerValue.borderColors[1],
                                              text2: providerValue
                                                  .test!
                                                  .questions[providerValue
                                                      .questionIndex]
                                                  .answers[1],
                                              index1: 0,
                                              index2: 1,
                                            ),
                                            LiveSessionQuizAnswerBox(
                                              color1: Colors.yellow,
                                              text1: providerValue
                                                  .test!
                                                  .questions[providerValue
                                                      .questionIndex]
                                                  .answers[2],
                                              changeBorder: providerValue
                                                  .changeActivePassive,
                                              color2: Colors.deepPurpleAccent,
                                              borderColor1:
                                                  providerValue.borderColors[2],
                                              borderColor2:
                                                  providerValue.borderColors[3],
                                              text2: providerValue
                                                  .test!
                                                  .questions[providerValue
                                                      .questionIndex]
                                                  .answers[3],
                                              index1: 2,
                                              index2: 3,
                                            ),
                                          ],
                                        )
                                      : LiveSessionDogruYanlisAnswerBox(
                                          color1: Colors.amber,
                                          text1: "Doğru",
                                          changeBorder: providerValue
                                              .dyChangeActivePassive,
                                          color2: Colors.blue.shade500,
                                          borderColor1:
                                              providerValue.dyBorderColors[0],
                                          borderColor2:
                                              providerValue.dyBorderColors[1],
                                          text2: "Yanlış",
                                        ),
                                  providerValue.test != null &&
                                          providerValue.isActive
                                      ? AnimatedContainer(
                                          onEnd: () {
                                            providerValue.showScore(context);

                                            Future.delayed(
                                                const Duration(seconds: 2), () {
                                              setState(() {
                                                restartAnimation();
                                              });
                                            });
                                            Future.delayed(
                                                const Duration(seconds: 7), () {
                                              setState(() {
                                                startAnimation();
                                              });
                                            });
                                          },
                                          duration: Duration(
                                              seconds: providerValue.isTable
                                                  ? 5
                                                  : providerValue
                                                      .test!
                                                      .questions[providerValue
                                                          .questionIndex]
                                                      .time), // Kısaltma süresi (örneğin 3 saniye)
                                          width: lineWidth,
                                          height: 5.0, // Çizgi kalınlığı
                                          color: Colors.black,
                                        )
                                      : const SizedBox.shrink()
                                ],
                              ),
                            ]),
                          ),
              )
            : Scaffold(
                backgroundColor: Colors.indigo.shade300,
                body: const Center(
                    child:
                        Text("Test Sahibi baslattiginda test baslayacaktir")),
              )); // not: sayfa icerisinde zaman gosterici olacak puan sistemi bu sayfanin notifierinda eklenecek
  }

  Expanded myActions(BuildContext context) {
    return Expanded(
      child: ListTile(
        title: providerValue.test == null
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.black,
              ))
            : Container(
                color: Colors.indigo.shade400,
                width: providerValue
                        .test!.questions[providerValue.questionIndex].isItQuiz
                    ? 100
                    : 150,
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: providerValue.isTable
                          ? const SizedBox.shrink()
                          : providerValue
                                  .test!
                                  .questions[providerValue.questionIndex]
                                  .isItQuiz
                              ? Image.asset("assets/images/options_6193980.png")
                              : Image.asset("assets/images/answer_3261305.png"),
                    ),
                    Expanded(
                      child: Text(
                          providerValue.isTable
                              ? "Liderlik Tablosu"
                              : providerValue
                                      .test!
                                      .questions[providerValue.questionIndex]
                                      .isItQuiz
                                  ? "Quiz"
                                  : "Doğru/Yanlış",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white)),
                    ),
                  ],
                ),
              ),
        leading: Text(
            providerValue.test != null
                ? "${providerValue.questionIndex + 1}/${providerValue.allQuestions!.length.toString()}"
                : '',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        trailing: PopupMenuButton<String>(
          iconSize: 25,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          onSelected: (value) {
            if (value == "cik") {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.indigo.shade100,
                  title: Text("Çıkmak istediğinizden emin misiniz ?",
                      style: TextStyle(color: Colors.indigo.shade500)),
                  actions: [
                    myButton("Hayır", "Evet"),
                  ],
                ),
              );
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem<String>(
                value: "cik",
                child: Text("Çık"), // Menü seçeneği metni
              ),
            ];
          },
        ),
      ),
    );
  }

  Row myButton(String text1, String text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(110, 45),
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black12))),
          onPressed: () => Navigator.pop(context),
          child: Text(
            text1,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black87),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(110, 45),
            backgroundColor: Colors.indigo.shade500,
          ),
          onPressed: () {
            providerValue.delete();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MyBottomNavigationBar()),
            );
          },
          child: Text(
            text2,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  void restartAnimation() {
    setState(() {
      lineWidth = 300;
    });
  }

  void startAnimation() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        lineWidth = 0; // Animasyonu başlatın
      });
    });
  }

  Padding myLiveSessionPicture() {
    return Padding(
      padding: const EdgeInsets.only(right: 5, left: 5, top: 5),
      child: Container(
        height: 210,
        width: double.infinity,
        color: Colors.indigo.shade100,
        child: providerValue.allQuestions![providerValue.questionIndex]
                    .urlQuestionPhoto !=
                ""
            ? Image.network(
                fit: BoxFit.cover,
                providerValue.allQuestions![providerValue.questionIndex]
                    .urlQuestionPhoto)
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/icons8-gallery-64.png"),
              ),
      ),
    );
  }

  ListTile myListTile(int index, String name, int score) {
    return ListTile(
      title: Text(
        name,
        style: const TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      leading: Text(
        index.toString(),
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
      ),
      trailing: Text(
        score.toString(),
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    providerValue.init(widget.testId);
    if (providerValue.isActive) {
      startAnimation();
    }
  }
}
