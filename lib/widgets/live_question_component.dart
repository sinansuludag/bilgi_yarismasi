import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifier_pages/live_session_quiz_shape_notifier.dart';
import 'live_session_dogruyanlis_answer_box.dart';
import 'live_session_question_container.dart';
import 'live_session_quiz_answer_box.dart';

class LiveQuestionComponent extends ConsumerWidget {
  const LiveQuestionComponent(
      {super.key, required this.isItQuiz, required this.providerValue});
  final bool
      isItQuiz; //soru 4 cevapli mi yoksa dogru yanlis mi anlamak icin parametre
  final MyLiveSessionQuizShapeNotifier providerValue;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String soru = "soru1";
    List<String> cevaplar = ["cevap 1", "cevap 2", "cevap 3 ", "cevap 4"];
    return Center(
      child: ListView(children: [
        Column(
          children: [
            myLiveSessionPicture(),
            const SizedBox(
              height: 5,
            ),
            LiveSessionQuestionContainer(
              text: soru,
            ),
            isItQuiz
                ? Column(
                    children: [
                      LiveSessionQuizAnswerBox(
                          color1: Colors.red,
                          text1: cevaplar[0],
                          changeBorder: providerValue.changeActivePassive,
                          color2: Colors.blue.shade500,
                          borderColor1: providerValue.borderColors[0],
                          borderColor2: providerValue.borderColors[1],
                          text2: cevaplar[1],
                          index1: 0,
                          index2: 1),
                      LiveSessionQuizAnswerBox(
                          color1: Colors.yellow,
                          text1: cevaplar[2],
                          changeBorder: providerValue.changeActivePassive,
                          color2: Colors.green,
                          borderColor1: providerValue.borderColors[2],
                          borderColor2: providerValue.borderColors[3],
                          text2: cevaplar[3],
                          index1: 2,
                          index2: 3)
                    ],
                  )
                : LiveSessionDogruYanlisAnswerBox(
                    color1: Colors.red,
                    text1: "Doğru",
                    changeBorder: providerValue.dyChangeActivePassive,
                    color2: Colors.blue.shade500,
                    borderColor1: providerValue.dyBorderColors[0],
                    borderColor2: providerValue.dyBorderColors[1],
                    text2: "Yanlış")
          ],
        ),
      ]),
    );
  }

  Padding myLiveSessionPicture() {
    return Padding(
      padding: const EdgeInsets.only(right: 5, left: 5, top: 5),
      child: Container(
        height: 210,
        width: double.infinity,
        color: Colors.indigo.shade100,
        child: const Center(),
      ),
    );
  }
}
