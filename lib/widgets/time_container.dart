import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeContainer extends ConsumerStatefulWidget {
  const TimeContainer(
      {super.key, required this.changeTimeFunc, required this.time});
  final Function changeTimeFunc;

  final int time;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TimeContainerState();
}

class _TimeContainerState extends ConsumerState<TimeContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              "  ${widget.time} sn",
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Row myTimeChooseWidget(String time1, time2) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              widget.changeTimeFunc(time1);
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
              widget.changeTimeFunc(time2);
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
}
