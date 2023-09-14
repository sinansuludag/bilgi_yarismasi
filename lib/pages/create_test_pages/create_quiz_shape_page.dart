import 'dart:io';

import 'package:bilgi_barismasi/Model/questions_model.dart';
import 'package:bilgi_barismasi/notifier_pages/create_quiz_shape_notifier.dart';
import 'package:bilgi_barismasi/service/riverpood_manager.dart';
import 'package:bilgi_barismasi/widgets/quiz_answer_box.dart';
import 'package:bilgi_barismasi/widgets/question_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/dogruyanlis_answer_box.dart';
import '../../widgets/point_component.dart';
import '../../widgets/time_container.dart';
import 'add_picture_screen_page.dart';

class MyQuizShapePage extends ConsumerStatefulWidget {
  const MyQuizShapePage({super.key, required this.isItQuiz});
  final bool isItQuiz;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MyQuizShapePageState();
}

class _MyQuizShapePageState extends ConsumerState<MyQuizShapePage> {
  late MyQuizShapeNotifier providerValue;
  File? photoFile;
  @override
  void initState() {
    super.initState();
    ref.read(myQuizShapeProvider);
  }

  @override
  Widget build(BuildContext context) {
    providerValue = ref.watch(myQuizShapeProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo.shade300,
        appBar: AppBar(
          backgroundColor: Colors.indigo.shade200,
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            myActions(context),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextButton(
                onPressed: () async {
                  File? result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddPictureScreenPage(),
                    ),
                  );

                  if (result != null) {
                    await providerValue.uploadImage(result);
                  }
                },
                child: Container(
                  height: 170,
                  width: double.infinity,
                  color: Colors.indigo.shade300,
                  child: providerValue.questionsImage != null
                      ? Image.file(
                          File(providerValue.questionsImage!.path),
                          fit: BoxFit.cover,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              color: Colors.indigo,
                              child: const Icon(Icons.add, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "Resim ekle",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )
                          ],
                        ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TimeContainer(
                      changeTimeFunc: providerValue.changeTimeSleep,
                      time: providerValue.timeSleep),
                  PointComponent(
                    changePointFunc: providerValue.changePoint,
                    point: providerValue.point,
                  )
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              QuestionContainer(
                  questionController: providerValue.questionEditController,
                  changeTextFunc: providerValue.changeText,
                  text: providerValue.questionText),
              const SizedBox(
                height: 3,
              ),
              (providerValue.indexOfShownQuestion ==
                              providerValue.questionModels.length &&
                          widget.isItQuiz) ||
                      (providerValue.indexOfShownQuestion !=
                              providerValue.questionModels.length &&
                          providerValue
                              .questionModels[
                                  providerValue.indexOfShownQuestion]
                              .isItQuiz)
                  ? Column(
                      children: [
                        MyQuizAnswerBox(
                          color1: Colors.red,
                          color2: Colors.blue.shade500,
                          answer1Controller:
                              providerValue.answer1EditController,
                          answer2Controller:
                              providerValue.answer2EditController,
                          changeTextFunc: providerValue.changeText,
                          text1: providerValue.answer1Text,
                          text2: providerValue.answer2Text,
                          switchIndex1: 0,
                          switchIndex2: 1,
                          onChangedFunc: providerValue.changeSwitchValue,
                          switchIndex: providerValue.switchIndex,
                          controllerIndex1: 1,
                          controllerIndex2: 2,
                        ),
                        MyQuizAnswerBox(
                          color1: Colors.yellow,
                          color2: Colors.green,
                          answer1Controller:
                              providerValue.answer3EditController,
                          answer2Controller:
                              providerValue.answer4EditController,
                          changeTextFunc: providerValue.changeText,
                          text1: providerValue.answer3Text,
                          text2: providerValue.answer4Text,
                          switchIndex1: 2,
                          switchIndex2: 3,
                          onChangedFunc: providerValue.changeSwitchValue,
                          switchIndex: providerValue.switchIndex,
                          controllerIndex1: 3,
                          controllerIndex2: 4,
                        ),
                      ],
                    )
                  : MyDogruYanlisAnswerBox(
                      color1: Colors.red,
                      color2: Colors.blue.shade500,
                      onChangedFunc: providerValue.dyChangeSwitchValue,
                      switchIndex: providerValue.dySwitchIndex,
                    ),
              Stack(
                children: [Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 80,
                      width: 300,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: providerValue.questionModels.length,
                        itemBuilder: (context, index) {
                          int number = index + 1;
                          return GestureDetector(
                            onTap: () {
                              providerValue.showQuestion(index);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              height: 70,
                              width: 70,
                              color: Colors.indigo,
                              child: Center(
                                  child: Text(
                                    number.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  )),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),

                  ],
                ), Positioned(
                  right: 5,
                  child: Container(
                    height: 70,
                    width: 70,
                    color: Colors.indigo,
                    child: myAddQuestionbutton(context),
                  ),
                ),],
              )
            ],
          ),
        ),
      ),
    );
  }

  TextButton myAddQuestionbutton(BuildContext context) {
    return TextButton(
        onPressed: () async {
          providerValue.addQuestion(widget.isItQuiz, context);
         // await Future.delayed(Duration(seconds: 1));
         // Navigator.pop(context);
        },
        child: const Icon(Icons.add, color: Colors.white));
  }



  Expanded myActions(BuildContext context) {
    return Expanded(
      child: ListTile(
        title: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Container(
            color: Colors.indigo.shade400,
            width: widget.isItQuiz ? 120 : 170,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.isItQuiz
                      ? Image.asset("assets/images/options_6193980.png")
                      : Image.asset("assets/images/answer_3261305.png"),
                ),
                Expanded(
                  child: Text(widget.isItQuiz ? "Quiz" : "Doğru/Yanlış",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
        leading: TextButton(
            onPressed: () {
              Navigator.pop<List<QuestionModel>>(
                  context, providerValue.questionModels);
            },
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.indigo.shade900,
              size: 30,
            )),
        trailing: PopupMenuButton<String>(
          iconSize: 25,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          onSelected: (value) {
            if (value == "sil") {
              if (providerValue.questionModels.isNotEmpty) {
                providerValue
                    .deleteQuestion(providerValue.indexOfShownQuestion);
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.indigo.shade100,
                    title: Center(
                        child: Text(
                      "Silinecek soru yok",
                      style: TextStyle(color: Colors.indigo.shade500),
                    )),
                  ),
                );
              }
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem<String>(
                value: "sil",
                child: Text("Sil"), // Menü seçeneği metni
              ),
            ];
          },
        ),
      ),
    );
  }
}
