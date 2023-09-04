import 'package:bilgi_barismasi/notifier_pages/create_dogruyanlis_shape_notifier.dart';
import 'package:bilgi_barismasi/notifier_pages/create_quiz_shape_notifier.dart';
import 'package:bilgi_barismasi/notifier_pages/live_session_quiz_shape_notifier.dart';
import 'package:bilgi_barismasi/service/riverpood_manager.dart';
import 'package:bilgi_barismasi/widgets/dogruyanlis_answer_box.dart';
import 'package:bilgi_barismasi/widgets/live_session_quiz_answer_box.dart';
import 'package:bilgi_barismasi/widgets/quiz_answer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifier_pages/live_session_dogruyanlis_shape_notifier.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/live_session_dogruyanlis_answer_box.dart';
import '../widgets/live_session_question_container.dart';
import '../widgets/question_container.dart';
import '../widgets/time_container.dart';

class MyQuizLiveSessionScreenPage extends ConsumerStatefulWidget {
  const MyQuizLiveSessionScreenPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MyQuizLiveSessionScreenPageeState();
}

class _MyQuizLiveSessionScreenPageeState
    extends ConsumerState<MyQuizLiveSessionScreenPage> {
  late MyLiveSessionQuizShapeNotifier providerValue;

  @override
  void initState() {
    super.initState();
    ref.read(myLiveSessionQuizShapeNotifier);
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.indigo.shade300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 150,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/icons8-cancel-48.png",
                  ),
                  Text(
                    "Yanlış",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 25,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, "/MyLeaderBoardPage"),
                child: Text(
                  "Devam et",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: Size(250, 50),
                    backgroundColor: Colors.indigo.shade900),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    providerValue = ref.watch(myLiveSessionQuizShapeNotifier);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo.shade300,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.indigo.shade200,
          actions: [
            myActions(context),
          ],
        ),
        body: Center(
          child: ListView(children: [
            Column(
              children: [
                myLiveSessionPicture(),
                SizedBox(
                  height: 5,
                ),
                LiveSessionQuestionContainer(
                  text: 'Sorular burada gorünecek',
                ),
                LiveSessionQuizAnswerBox(
                    color1: Colors.red,
                    text1: "Cevaplar burada gözukecek",
                    changeBorder: providerValue.changeActivePassive,
                    color2: Colors.blue.shade500,
                    borderColor1: providerValue.borderColors[0],
                    borderColor2: providerValue.borderColors[1],
                    text2: "Cevaplar burada gözukecek",
                    index1: 0,
                    index2: 1),
                LiveSessionQuizAnswerBox(
                    color1: Colors.yellow,
                    text1: "Cevaplar burada gözukecek",
                    changeBorder: providerValue.changeActivePassive,
                    color2: Colors.green,
                    borderColor1: providerValue.borderColors[2],
                    borderColor2: providerValue.borderColors[3],
                    text2: "Cevaplar burada gözukecek",
                    index1: 2,
                    index2: 3)
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Padding myLiveSessionPicture() {
    return Padding(
      padding: const EdgeInsets.only(right: 5, left: 5, top: 5),
      child: Container(
        height: 210,
        width: double.infinity,
        color: Colors.indigo.shade100,
        child: Center(),
      ),
    );
  }

  Expanded myActions(BuildContext context) {
    return Expanded(
      child: ListTile(
        title: Container(
          margin: EdgeInsets.only(left: 25),
          width: 160,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 30,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Image.asset("assets/images/options_6193980.png")),
              ),
              const Expanded(
                child: Text("Quiz",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white)),
              ),
            ],
          ),
        ),
        leading: Text("1/1",
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
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
