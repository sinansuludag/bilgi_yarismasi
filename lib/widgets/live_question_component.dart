import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifier_pages/live_session_quiz_shape_notifier.dart';
import 'live_session_dogruyanlis_answer_box.dart';
import 'live_session_question_container.dart';
import 'live_session_quiz_answer_box.dart';

class LiveQuestionComponent extends ConsumerWidget {
  const LiveQuestionComponent({super.key, required this.providerValue});

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
              text: providerValue
                  .test!.questions[providerValue.questionIndex].question,
            ),
            providerValue.test!.questions[providerValue.questionIndex].isItQuiz
                ? Column(
                    children: [
                      LiveSessionQuizAnswerBox(
                        color1: Colors.red,
                        text1: providerValue.test!
                            .questions[providerValue.questionIndex].answers[0],
                        changeBorder: providerValue.changeActivePassive,
                        color2: Colors.blue.shade500,
                        borderColor1: providerValue.borderColors[0],
                        borderColor2: providerValue.borderColors[1],
                        text2: providerValue.test!
                            .questions[providerValue.questionIndex].answers[1],
                        index1: 0,
                        index2: 1,
                        bottomsheet: showBottomSheet,
                      ),
                      LiveSessionQuizAnswerBox(
                          color1: Colors.yellow,
                          text1: providerValue
                              .test!
                              .questions[providerValue.questionIndex]
                              .answers[2],
                          changeBorder: providerValue.changeActivePassive,
                          color2: Colors.green,
                          borderColor1: providerValue.borderColors[2],
                          borderColor2: providerValue.borderColors[3],
                          text2: providerValue
                              .test!
                              .questions[providerValue.questionIndex]
                              .answers[3],
                          index1: 2,
                          index2: 3,
                          bottomsheet: showBottomSheet),
                    ],
                  )
                : LiveSessionDogruYanlisAnswerBox(
                    color1: Colors.red,
                    text1: "Doğru",
                    changeBorder: providerValue.dyChangeActivePassive,
                    color2: Colors.blue.shade500,
                    borderColor1: providerValue.dyBorderColors[0],
                    borderColor2: providerValue.dyBorderColors[1],
                    text2: "Yanlış",
                    bottomSheet: showBottomSheet,
                  )
          ],
        ),
      ]),
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.indigo.shade300,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return SizedBox(
          height: 150,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/icons8-cancel-48.png",
                  ),
                  const Text(
                    "Yanlış",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 25,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/MyLeaderBoardPage");
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(250, 50),
                    backgroundColor: Colors.indigo.shade900),
                child: const Text(
                  "Devam et",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
