import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyDogruYanlisAnswerBox extends ConsumerStatefulWidget {
   MyDogruYanlisAnswerBox(
      {super.key,
      required this.color1,
      required this.color2,
        required this.onChangedFunc,
        required this.switchIndex
     });
  final Color color1;
  final Color color2;
  final Function onChangedFunc;
   final List<bool> switchIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MyDogruYanlisAnswerBoxState();
}

class _MyDogruYanlisAnswerBoxState
    extends ConsumerState<MyDogruYanlisAnswerBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Stack(
                  children:[ Container(
                    decoration: BoxDecoration(
                      color: widget.color1,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: 200,
                    width: 200,
                    child: TextButton(
                      onPressed: () {
                        widget.onChangedFunc(0);
                      },
                      child: Text("Doğru", style: TextStyle(color: Colors.white)),
                    ),
                  ), Positioned(
                      top: 0,
                      right: 0,
                      child: Switch(
                        activeColor: Colors.black87,
                        value: widget.switchIndex[0],
                        onChanged: (value) {
                          if (value) {
                            widget.onChangedFunc(0);
                          }
                        },
                      ))]
                ),),
            const SizedBox(
              width: 5,
            ),
            Expanded(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: widget.color2,
                        borderRadius: BorderRadius.circular(8),
                        // border: Border.all(color: widget.borderColor2,width: 4),
                      ),
                      height: 200,
                      width: 200,
                      child: TextButton(
                        onPressed: () {
                         widget.onChangedFunc(1);
                        },
                        child: Text("Yanlış", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: Switch(
                          activeColor: Colors.black87,
                          value: widget.switchIndex[1],
                          onChanged: (value) {
                            if (value) {
                              widget.onChangedFunc(1);
                            }
                          },
                        ),),
                  ],
                )),
          ],
        ),
      );
  }
}
