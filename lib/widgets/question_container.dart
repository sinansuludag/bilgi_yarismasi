import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionContainer extends ConsumerStatefulWidget {
  const QuestionContainer(
      {super.key,
      required this.questionController,
      required this.changeTextFunc,
      required this.text});

  final TextEditingController questionController;
  final Function changeTextFunc;
  final String text;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuestionContainerState();
}

class _QuestionContainerState extends ConsumerState<QuestionContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextField(
                          controller: widget.questionController,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          cursorColor: Colors.indigo.shade900,
                          decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.indigo.shade900),
                              ),
                              hintStyle: const TextStyle(
                                color: Colors.indigo,
                              )),
                        ),
                        Container(
                          child: ElevatedButton(
                            onPressed: () {
                              widget.changeTextFunc(0);

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
          child: Text(
            widget.text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
