import 'package:bilgi_barismasi/notifier_pages/live_session_quiz_shape_notifier.dart';
import 'package:bilgi_barismasi/service/riverpood_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          actions: [
            myActions(context),
          ],
        ),
        body:
            LiveQuestionComponent(isItQuiz: true, providerValue: providerValue),
      ),
    ); // not: sayfa icerisinde zaman gosterici olacak puan sistemi bu sayfanin notifierinda eklenecek
  }

  Expanded myActions(BuildContext context) {
    return Expanded(
      child: ListTile(
        title: Container(
          margin: const EdgeInsets.only(left: 25),
          width: 160,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 30,
              ),
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
        leading: const Text("1/1",
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
