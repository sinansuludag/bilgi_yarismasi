import 'package:bilgi_barismasi/notifier_pages/create_dogruyanlis_shape_notifier.dart';
import 'package:bilgi_barismasi/service/riverpood_manager.dart';
import 'package:bilgi_barismasi/widgets/dogruyanlis_answer_box.dart';
import 'package:bilgi_barismasi/widgets/point_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../notifier_pages/live_session_quiz_shape_notifier.dart';
import '../../widgets/bottom_navigation_bar.dart';
import '../../widgets/question_container.dart';
import '../../widgets/time_container.dart';

class MyDogruYanlisShapePage extends ConsumerStatefulWidget {
  const MyDogruYanlisShapePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MyDogruYanlisShapePageState();
}

class _MyDogruYanlisShapePageState
    extends ConsumerState<MyDogruYanlisShapePage> {
  late MyDogruYanlisShapeNotifier providerValue;
  @override
  void initState() {
    super.initState();
    ref.read(myDogruYanlisShapeProvider);
  }

  @override
  Widget build(BuildContext context) {
    providerValue = ref.watch(myDogruYanlisShapeProvider);
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
                onPressed: () {},
                child: Container(
                  height: 170,
                  width: double.infinity,
                  color: Colors.indigo.shade300,
                  child: Center(
                    child: Column(
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
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TimeContainer(
                      changeTimeFunc: providerValue.changeTimeSleep,
                      time: providerValue.timeSleep),
                  PointComponent(changePointFunc:providerValue.changePoint, point: providerValue.point),
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
              MyDogruYanlisAnswerBox(
                color1: Colors.red,
                color2: Colors.blue.shade500, onChangedFunc: providerValue.changeSwitchValue, switchIndex:providerValue.dySwitchIndex,
              ),
              Container(
                margin: const EdgeInsets.only(left: 300),
                height: 70,
                width: 70,
                color: Colors.indigo,
                child: TextButton(
                    onPressed: () {},
                    child: const Icon(Icons.add, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded myActions(BuildContext context) {
    return Expanded(
      child: ListTile(
        title: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Container(
            color: Colors.indigo.shade400,
            width: 170,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/images/answer_3261305.png"),
                ),
                const Expanded(
                  child: Text("Doğru/Yanlış",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white)),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.indigo.shade100,
                ),
              ],
            ),
          ),
        ),
        leading: TextButton(
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyBottomNavigationBar()),
                ),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.indigo.shade900,
              size: 30,
            )),
        trailing: TextButton(
            onPressed: () {},
            child: Icon(
              Icons.menu,
              color: Colors.indigo.shade900,
              size: 30,
            )),
      ),
    );
  }
}
