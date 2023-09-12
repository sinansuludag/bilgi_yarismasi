import 'package:bilgi_barismasi/notifier_pages/live_session_quiz_shape_notifier.dart';
import 'package:bilgi_barismasi/service/riverpood_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/bottom_navigation_bar.dart';
import '../../widgets/live_question_component.dart';

//artik bu sayfadan hem dogru yanlis sorulari hemde quix sorulari goruntulenebiliyor
class MyLiveTestSessionScreenPage extends ConsumerStatefulWidget {
  const MyLiveTestSessionScreenPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MyLiveTestSessionScreenPageState();
}

class _MyLiveTestSessionScreenPageState
    extends ConsumerState<MyLiveTestSessionScreenPage> {
  late MyLiveSessionQuizShapeNotifier providerValue;
  bool isItQuiz=true;
  @override
  void initState() {
    super.initState();
    ref.read(myLiveSessionQuizShapeNotifier);
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
                onPressed: () =>
                    Navigator.pushNamed(context, "/MyLeaderBoardPage"),
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

  @override
  Widget build(BuildContext context) {
    providerValue = ref.watch(myLiveSessionQuizShapeNotifier);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo.shade300,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.indigo.shade200,
          actions: [myActions(context)],
        ),
        body:
            LiveQuestionComponent(isItQuiz: isItQuiz, providerValue: providerValue),
      ),
    ); // not: sayfa icerisinde zaman gosterici olacak puan sistemi bu sayfanin notifierinda eklenecek
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
            width: isItQuiz ? 120 : 170,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:isItQuiz
                      ? Image.asset("assets/images/options_6193980.png")
                      : Image.asset("assets/images/answer_3261305.png"),
                ),
                Expanded(
                  child: Text(isItQuiz ? "Quiz" : "Doğru/Yanlış",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
        leading: Text("1/2",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
        trailing: PopupMenuButton<String>(
          iconSize: 25,
          shape: RoundedRectangleBorder(
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
              PopupMenuItem<String>(
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
              minimumSize: Size(110, 45),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black12))),
          onPressed: () => Navigator.pop(context),
          child: Text(
            text1,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black87),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(110, 45),
            backgroundColor: Colors.indigo.shade500,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyBottomNavigationBar()),
            );
          },
          child: Text(
            text2,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

}
