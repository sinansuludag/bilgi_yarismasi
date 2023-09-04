// import 'package:bilgi_barismasi/notifier_pages/create_dogruyanlis_shape_notifier.dart';
// import 'package:bilgi_barismasi/service/riverpood_manager.dart';
// import 'package:bilgi_barismasi/widgets/dogruyanlis_answer_box.dart';
// import 'package:bilgi_barismasi/widgets/quiz_answer_box.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../notifier_pages/live_session_dogruyanlis_shape_notifier.dart';
// import '../../widgets/bottom_navigation_bar.dart';
// import '../../widgets/live_session_dogruyanlis_answer_box.dart';
// import '../../widgets/live_session_question_container.dart';
// import '../../widgets/question_container.dart';
// import '../../widgets/time_container.dart';

// class MyDogruYanlisLiveSessionScreenPage extends ConsumerStatefulWidget {
//   const MyDogruYanlisLiveSessionScreenPage({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _MyLiveSessionScreenPageState();
// }

// class _MyLiveSessionScreenPageState
//     extends ConsumerState<MyDogruYanlisLiveSessionScreenPage> {
//   late MyLiveSessionDogruYanlisShapeNotifier providerValue;

//   @override
//   void initState() {
//     super.initState();
//     ref.read(myLiveSessionDogruYanlisShapeNotifier);
//   }

//   void showBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       backgroundColor: Colors.indigo.shade300,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(16),
//           topRight: Radius.circular(16),
//         ),
//       ),
//       context: context,
//       builder: (BuildContext context) {
//         return SizedBox(
//           height: 150,
//           width: double.infinity,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     "assets/images/icons8-cancel-48.png",
//                   ),
//                   const Text(
//                     "Yanlış",
//                     style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 25,
//                         fontWeight: FontWeight.w900),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 25,
//               ),
//               ElevatedButton(
//                 onPressed: () =>
//                     Navigator.pushNamed(context, "/MyLeaderBoardPage"),
//                 style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     minimumSize: const Size(250, 50),
//                     backgroundColor: Colors.indigo.shade900),
//                 child: Text(
//                   "Devam et",
//                   style: TextStyle(
//                     fontWeight: FontWeight.w900,
//                     fontSize: 22,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     providerValue = ref.watch(myLiveSessionDogruYanlisShapeNotifier);
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.indigo.shade300,
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: Colors.indigo.shade200,
//           actions: [
//             myActions(context),
//           ],
//         ),
//         body: Center(
//           child: ListView(children: [
//             Column(
//               children: [
//                 myLiveSessionPicture(),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 const LiveSessionQuestionContainer(
//                   text: 'Sorular burada gorünecek',
//                 ),
//                 LiveSessionDogruYanlisAnswerBox(
//                     color1: Colors.red,
//                     text1: "Doğru",
//                     changeBorder: providerValue.changeActivePassive,
//                     color2: Colors.blue.shade500,
//                     borderColor1: providerValue.borderColors[0],
//                     borderColor2: providerValue.borderColors[1],
//                     text2: "Yanlış")
//               ],
//             ),
//           ]),
//         ),
//       ),
//     );
//   }

//   Padding myLiveSessionPicture() {
//     return Padding(
//       padding: const EdgeInsets.only(right: 5, left: 5, top: 5),
//       child: Container(
//         height: 210,
//         width: double.infinity,
//         color: Colors.indigo.shade100,
//         child: const Center(),
//       ),
//     );
//   }

//   Expanded myActions(BuildContext context) {
//     return Expanded(
//       child: ListTile(
//         title: Container(
//           margin: const EdgeInsets.only(left: 25),
//           width: 160,
//           height: 50,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Image.asset("assets/images/answer_3261305.png"),
//               ),
//               const Expanded(
//                 child: Text("Doğru/Yanlış",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                         color: Colors.white)),
//               ),
//             ],
//           ),
//         ),
//         leading: const Text("1/1",
//             style: TextStyle(
//                 fontSize: 20,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold)),
//         trailing: TextButton(
//             onPressed: () {},
//             child: Icon(
//               Icons.menu,
//               color: Colors.indigo.shade900,
//               size: 30,
//             )),
//       ),
//     );
//   }
// }
