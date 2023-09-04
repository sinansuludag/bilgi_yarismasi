
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiveSessionQuestionContainer extends ConsumerStatefulWidget {


  const LiveSessionQuestionContainer(
      {super.key,required this.text,
       });
   final String text;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LiveSessionQuestionContainerState();
}

class _LiveSessionQuestionContainerState extends ConsumerState<LiveSessionQuestionContainer> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.indigo.shade200,
        ),
        height: 85,
        width: double.infinity,
        child: Center(child: Text(widget.text,style: TextStyle(color:Colors.white,fontSize: 20, ),)),
      ),
    );
  }

}
