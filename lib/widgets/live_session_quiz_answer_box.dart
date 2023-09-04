import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiveSessionQuizAnswerBox extends ConsumerStatefulWidget {
  const LiveSessionQuizAnswerBox({
    super.key,
    required this.color1,
    required this.text1,
    required this.changeBorder,
    required this.color2,required this.borderColor1,required this.borderColor2,required this.text2,required this.index1,required this.index2
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
            onPressed: () {widget.changeBorder(widget.index1);},
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: widget.borderColor1,width: 4),
                  borderRadius: BorderRadius.circular(8), color: widget.color1),
              width: 190,
              height: 100,
              child: Center(
                  child: Text(
                    widget.text1,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  )),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: TextButton(
            onPressed: () {widget.changeBorder(widget.index2);},
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: widget.borderColor2,width: 4),
                  borderRadius: BorderRadius.circular(8), color: widget.color2),
              width: 190,
              height: 100,
              child: Center(
                  child: Text(
                    widget.text2,
                    style: TextStyle(
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
