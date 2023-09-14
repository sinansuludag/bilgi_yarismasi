import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiveSessionQuizAnswerBox extends ConsumerStatefulWidget {
  const LiveSessionQuizAnswerBox({
    super.key,
    required this.color1,
    required this.text1,
    required this.changeBorder,
    required this.color2,
    required this.borderColor1,
    required this.borderColor2,
    required this.text2,
    required this.index1,
    required this.index2,
    required this.bottomsheet,
  });
  final color1;
  final color2;
  final text1;
  final text2;
  final Function changeBorder;
  final borderColor1;
  final borderColor2;
  final index1;
  final index2;
  final Function bottomsheet;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LiveSessionQuizAnswerBox();
}

class _LiveSessionQuizAnswerBox
    extends ConsumerState<LiveSessionQuizAnswerBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              widget.changeBorder(widget.index1);
              // widget.bottomsheet(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: widget.borderColor1, width: 4),
                  borderRadius: BorderRadius.circular(8),
                  color: widget.color1),
              width: 190,
              height: 100,
              child: Center(
                  child: Text(
                widget.text1,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18),
              )),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              widget.changeBorder(widget.index2);
              // widget.bottomsheet(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: widget.borderColor2, width: 4),
                  borderRadius: BorderRadius.circular(8),
                  color: widget.color2),
              width: 190,
              height: 100,
              child: Center(
                  child: Text(
                widget.text2,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18),
              )),
            ),
          ),
        ),
      ],
    );
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
}
