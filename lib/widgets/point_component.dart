import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PointComponent extends ConsumerStatefulWidget {
  const PointComponent(
      {super.key, required this.changePointFunc, required this.point});
  final Function changePointFunc;

  final int point;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PointComponentState();
}

class _PointComponentState extends ConsumerState<PointComponent> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.indigo.shade100,
            title: Text(
              "Puan",
              style: TextStyle(color: Colors.indigo.shade900),
              textAlign: TextAlign.center,
            ),
            content: SizedBox(
              height: 330,
              child: Column(children: [
                myPointChooseWidget("500", "1000"),
                myPointChooseWidget("1500", "2000"),
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
        backgroundColor: Colors.lightBlue.shade900,
      ),
      child: Text(
        "  ${widget.point} puan",
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  Row myPointChooseWidget(String point1, point2) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              widget.changePointFunc(point1);
            },
            child: Container(
              height: 50,
              width: 100,
              color: Colors.white,
              child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Text("$point1",
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
              widget.changePointFunc(point2);
            },
            child: Container(
              height: 50,
              width: 100,
              color: Colors.white,
              child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Text("$point2",
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
}
