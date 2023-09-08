import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bottom_navigation_bar.dart';

class LiveScreenAppBarComponent extends ConsumerWidget {
  const LiveScreenAppBarComponent({Key? key, required this.isItAppbar})
      : super(key: key);
  final bool isItAppbar;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    return Expanded(
      child: ListTile(
        title: Container(
          margin: const EdgeInsets.only(left: 25),
          width: 160,
          height: 50,
          child: isItAppbar
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child:
                              Image.asset("assets/images/options_6193980.png")),
                    ),
                    const Expanded(
                      child: Text("Quiz",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white)),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child:
                              Image.asset("assets/images/answer_3261305.png")),
                    ),
                    const Expanded(
                      child: Text("Doğru/Yanlış",
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
}
