import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiveSessionDogruYanlisAnswerBox extends ConsumerStatefulWidget {
  const LiveSessionDogruYanlisAnswerBox({
    super.key,
    required this.color1,
    required this.text1,
    required this.changeBorder,
    required this.color2,
    required this.borderColor1,
    required this.borderColor2,
    required this.text2,
    required this.bottomSheet,
  });
  final color1;
  final color2;
  final text1;
  final text2;
  final Function changeBorder;
  final borderColor1;
  final borderColor2;
  final Function bottomSheet;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LiveSessionDogruYanlisAnswerBox();
}

class _LiveSessionDogruYanlisAnswerBox
    extends ConsumerState<LiveSessionDogruYanlisAnswerBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              widget.changeBorder(0);
              // widget.bottomSheet(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: widget.borderColor1, width: 4),
                  borderRadius: BorderRadius.circular(8),
                  color: widget.color1),
              width: 200,
              height: 210,
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
              widget.changeBorder(1);
              // widget.bottomSheet(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: widget.borderColor2, width: 4),
                  borderRadius: BorderRadius.circular(8),
                  color: widget.color2),
              width: 200,
              height: 210,
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
}
