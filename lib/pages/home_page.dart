import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:bilgi_barismasi/Model/questions_model.dart';
import 'package:bilgi_barismasi/notifier_pages/home_page_notifier.dart';
import 'package:bilgi_barismasi/service/remote_datasource.dart';
import 'package:bilgi_barismasi/service/riverpood_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with AfterLayoutMixin {
  late HomePageNotifier providerValue;
  @override
  void initState() {
    super.initState();
    ref.read(homePageProvider);
  }

  @override
  Widget build(BuildContext context) {
    providerValue = ref.watch(homePageProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo.shade300,
        appBar: AppBar(
          title: Text(
            "Soru Kitapçıklarım",
            style: TextStyle(
              fontFamily: "DancingScript",
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: Colors.indigo.shade900,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.indigo.shade200,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount:
                providerValue.tests != null ? providerValue.tests!.length : 0,
            itemBuilder: (context, index) {
              if (providerValue.tests != null) {
                return testContainer(context, providerValue.tests![index]);
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    providerValue.getTestDatas();
  }

  InkWell testContainer(BuildContext context, TestModel? test) {
    return InkWell(
      onTap: () => showBottomSheet(context, test),
      onLongPress: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            Column(
              children: [
                Text(
                  "Soru kitapçığı silinsin mi ?",
                  style: TextStyle(
                    color: Colors.indigo.shade500,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    myElevatedButton(
                        context, "İptal", () => Navigator.pop(context)),
                    const SizedBox(
                      width: 8,
                    ),
                    myElevatedButton(context, "Sil", () async {FirebaseService firebaseService=FirebaseService();
                      await firebaseService.addTestToFirestore(test!);
                    }),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                width: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          test != null ? test.nameOfTheTest : "None",
                          style: const TextStyle(
                            color: Colors.indigo,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        leading: Container(
                          height: 60,
                          width: 70,
                          color: Colors.indigo.shade200,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/images/icons8-gallery-64.png"),
                          ),
                        ),
                        subtitle: Text(
                          test != null
                              ? "${test.numberOfQuestions} soru"
                              : "None",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.indigo.shade500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context, TestModel? test) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            FractionallySizedBox(
              heightFactor: 0.85,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.indigo.shade300,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: Container(
                          width: double.infinity,
                          height: 200,
                          color: Colors.indigo.shade100,
                          child: const Center(
                            child: Text("Sorular",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 50,
                                    fontFamily: "DancingScript")),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.indigo.shade200,
                        height: 70,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            test != null ? test.nameOfTheTest : "None",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 5,
                      endIndent: 10,
                      indent: 10,
                      color: Colors.white,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: test != null ? test.questions.length : 0,
                      itemBuilder: (context, index) {
                        if (test != null) {
                          return myListTile(test.questions[index], index);
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: 400,
                height: 75,
                color: Colors.indigo.shade300,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(double.infinity, 55)),
                      onPressed: () => Navigator.pushNamed(
                          context, "/MyQuizLiveSessionScreenPage"),
                      child: const Text(
                        "Başlat",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Padding myListTile(QuestionModel question, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
      child: Card(
        color: Colors.white70,
        child: ListTile(
          title: Text(
              question.isItQuiz ? "${index+1}- Quiz" : "${index+1} - Doğru/Yanlış"),
          subtitle: Text((question.question)),
          leading: Container(
            height: 60,
            width: 70,
            color: Colors.indigo.shade200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/images/icons8-gallery-64.png"),
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton myElevatedButton(
      BuildContext context, String text, Function function) {
    return ElevatedButton(
      onPressed: () => function(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo.shade500,
      ),
      child: Text(
        text,
      ),
    );
  }


}
