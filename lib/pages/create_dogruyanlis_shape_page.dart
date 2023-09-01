import 'package:bilgi_barismasi/notifier_pages/create_dogruyanlis_shape_notifier.dart';
import 'package:bilgi_barismasi/service/riverpood_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/bottom_navigation_bar.dart';

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
              Container(
                margin: const EdgeInsets.only(right: 240),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.indigo.shade100,
                        title: Text(
                          "Zaman sınırı",
                          style: TextStyle(color: Colors.indigo.shade900),
                          textAlign: TextAlign.center,
                        ),
                        content: SizedBox(
                          height: 330,
                          child: Column(children: [
                            myTimeChooseWidget("5", "10"),
                            myTimeChooseWidget("20", "30"),
                            myTimeChooseWidget("60", "90"),
                            myTimeChooseWidget("120", "180"),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.indigo.shade300),
                                child: const Text("Bitti"),
                              ),
                            )
                          ]),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.watch_later_outlined),
                      Text(
                        "  ${providerValue.timeSleep} sn",
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.indigo.shade100,
                      borderRadius: BorderRadius.circular(8)),
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Soruyu gir"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextField(
                                    controller:
                                        providerValue.questionEditController,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    cursorColor: Colors.indigo.shade900,
                                    decoration: InputDecoration(
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.indigo.shade900),
                                        ),
                                        hintStyle: const TextStyle(
                                          color: Colors.indigo,
                                        )),
                                  ),
                                  Container(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        providerValue.changeText(
                                            providerValue
                                                .questionEditController,
                                            0);

                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.indigo.shade300),
                                      child: const Text("Bitti"),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Text(
                      providerValue.questionText,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              myAnswerBox(Colors.red, Colors.blue, context),
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
            height: 200,
            width: 100,
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Cevap ekle"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextField(
                              controller: providerValue.answer1EditController,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              cursorColor: Colors.indigo.shade900,
                              decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.indigo.shade900),
                                  ),
                                  hintStyle: const TextStyle(
                                    color: Colors.indigo,
                                  )),
                            ),
                            Container(
                              child: ElevatedButton(
                                onPressed: () {
                                  providerValue.changeText(
                                      providerValue.answer1EditController, 1);

                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.indigo.shade300),
                                child: const Text("Bitti"),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Text(providerValue.answer1Text,
                  style: const TextStyle(color: Colors.white)),
            ),
          )),
          const SizedBox(
            width: 6,
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              color: color2,
              borderRadius: BorderRadius.circular(8),
            ),
            height: 200,
            width: 100,
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Cevap ekle"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextField(
                              controller: providerValue.answer2EditController,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              cursorColor: Colors.indigo.shade900,
                              decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.indigo.shade900),
                                  ),
                                  hintStyle: const TextStyle(
                                    color: Colors.indigo,
                                  )),
                            ),
                            Container(
                              child: ElevatedButton(
                                onPressed: () {
                                  providerValue.changeText(
                                      providerValue.answer2EditController, 2);

                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.indigo.shade300),
                                child: const Text("Bitti"),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Text(providerValue.answer2Text,
                  style: const TextStyle(color: Colors.white)),
            ),
          )),
        ],
      ),
    );
  }

  Row myTimeChooseWidget(String time1, time2) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              providerValue.changeTimeSleep(time1);
            },
            child: Container(
              height: 50,
              width: 100,
              color: Colors.white,
              child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Text("$time1 sn",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      textAlign: TextAlign.center)),
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              providerValue.changeTimeSleep(time2);
            },
            child: Container(
              height: 50,
              width: 100,
              color: Colors.white,
              child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Text("$time2 sn",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      textAlign: TextAlign.center)),
            ),
          ),
        )
      ],
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

// class MyDogruYanlisShapePage extends StatelessWidget {
//   const MyDogruYanlisShapePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.indigo.shade300,
//         appBar: AppBar(
//           backgroundColor: Colors.indigo.shade200,
//           centerTitle: true,
//           automaticallyImplyLeading: false,
//           actions: [
//             myActions(context),
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextButton(
//                 onPressed: () {},
//                 child: Container(
//                   height: 170,
//                   width: double.infinity,
//                   color: Colors.indigo.shade300,
//                   child: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Container(
//                           height: 35,
//                           width: 35,
//                           color: Colors.indigo,
//                           child: const Icon(Icons.add, color: Colors.white),
//                         ),
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         const Text(
//                           "Resim ekle",
//                           style: TextStyle(color: Colors.white, fontSize: 16),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(right: 240),
//                 child: ElevatedButton(
//                   onPressed: () { showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       backgroundColor: Colors.indigo.shade100,
//                       title: Text("Zaman sınırı",style: TextStyle(color: Colors.indigo.shade900),textAlign: TextAlign.center,),
//                       content: SizedBox(
//                         height: 330,
//                         child: Column(children: [
//                           myTimeChooseWidget("5 sn","10 sn"),
//                           myTimeChooseWidget("20 sn","30 sn"),
//                           myTimeChooseWidget("60 sn","90 sn"),
//                           myTimeChooseWidget("120 sn","180 sn"),
//                           Container(
//                             margin: const EdgeInsets.only(top: 15),
//                             child: ElevatedButton(onPressed:() {
//                               //saniyeler tutulacak

//                             },
//                               style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo.shade300), child:Text("Bitti"),),
//                           )
//                         ]),
//                       ),
//                     ),
//                   );},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.deepPurpleAccent,

//                   ),
//                   child: const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(Icons.watch_later_outlined),
//                       Text(
//                         "  20 sn",
//                         style: TextStyle(fontSize: 20, color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 7,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 100,
//                   width: double.infinity,
//                   // color: Colors.indigo.shade100,
//                   decoration: BoxDecoration(
//                       color: Colors.indigo.shade100,
//                       borderRadius: BorderRadius.circular(8)),
//                   child: TextButton(
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         builder: (context) => AlertDialog(
//                           title: Text("Soruyu gir"),
//                           content: MyTextFieldPage(),
//                         ),
//                       );
//                     },
//                     child: Text(
//                       "Soru eklemek için dokunun",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 3,
//               ),
//               myAnswerBox(Colors.red, Colors.blue,context),
//               Container(
//                 margin: const EdgeInsets.only(left: 300),
//                 height: 70,
//                 width: 70,
//                 color: Colors.indigo,
//                 child: TextButton(onPressed: () {

//                 },child: const Icon(Icons.add, color: Colors.white)),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
