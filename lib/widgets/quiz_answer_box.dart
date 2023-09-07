import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyQuizAnswerBox extends ConsumerStatefulWidget {
  MyQuizAnswerBox({
    this.val = false,
    super.key,
    required this.color1,
    required this.color2,
    required this.answer1Controller,
    required this.answer2Controller,
    required this.changeTextFunc,
    required this.text1,
    required this.text2,
    required this.index1,
    required this.index2,
    required this.onChangedFunc,
    required this.switchIndex,
  });
  final Color color1;
  final Color color2;
  final TextEditingController answer1Controller;
  final TextEditingController answer2Controller;
  final Function changeTextFunc;
  final String text1;
  final String text2;
  final int index1;
  final int index2;
  final List<bool> switchIndex;
  bool val;
  final Function onChangedFunc;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MyQuizAnswerBoxState();
}

class _MyQuizAnswerBoxState extends ConsumerState<MyQuizAnswerBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: widget.color1,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 100,
                  width: 200,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextField(
                                    controller: widget.answer1Controller,
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
                                        widget.changeTextFunc(widget.index1);

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
                    child: Text(widget.text1,
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: Switch(
                      activeColor: Colors.black87,
                      value: widget.switchIndex[widget.index1],
                      onChanged: (value) {
                        if (value) {
                          widget.onChangedFunc(widget.index1);
                        }
                      },
                    ))
              ],
            ),
          ),
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
                  ),
                  height: 100,
                  width: 200,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextField(
                                    controller: widget.answer2Controller,
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
                                        widget.changeTextFunc(widget.index2);

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
                    child: Text(widget.text2,
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: Switch(
                      activeColor: Colors.black87,
                      value: widget.switchIndex[widget.index2],
                      onChanged: (value) {
                        if (value) {
                          widget.onChangedFunc(widget.index2);
                        }
                      },
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
