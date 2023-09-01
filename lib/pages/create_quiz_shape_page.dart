import 'package:bilgi_barismasi/notifier_pages/create_quiz_shape_notifier.dart';
import 'package:bilgi_barismasi/service/riverpood_manager.dart';
import 'package:bilgi_barismasi/widgets/question_container.dart';
import 'package:bilgi_barismasi/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/time_container.dart';

class MyQuizShapePage extends ConsumerStatefulWidget {
  const MyQuizShapePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MyQuizShapePageState();
}

class _MyQuizShapePageState extends ConsumerState<MyQuizShapePage> {
  late MyQuizShapeNotifier providerValue;
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
              TimeContainer(
                  changeTimeFunc: providerValue.changeTimeSleep,
                  time: providerValue.timeSleep),
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
              myAnswerBox(Colors.red, Colors.blue, context),
              myAnswerBox(Colors.yellow, Colors.green, context),
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

  Padding myAnswerBox(Color color1, Color color2, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              color: color1,
              borderRadius: BorderRadius.circular(8),
            ),
            height: 100,
            width: 180,
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    title: Text("Cevap ekle"),
                    content: MyTextFieldPage(),
                  ),
                );
              },
              child: const Text("Cevap ekle",
                  style: TextStyle(color: Colors.white)),
            ),
          )),
          const SizedBox(
            width: 5,
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              color: color2,
              borderRadius: BorderRadius.circular(8),
            ),
            height: 100,
            width: 180,
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    title: Text("Cevap ekle"),
                    content: MyTextFieldPage(),
                  ),
                );
              },
              child: const Text("Cevap ekle",
                  style: TextStyle(color: Colors.white)),
            ),
          )),
        ],
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
            width: 130,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/images/options_6193980.png"),
                ),
                const Text("Quiz",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white)),
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
