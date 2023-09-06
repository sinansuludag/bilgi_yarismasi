import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyDogruYanlisAnswerBox extends ConsumerStatefulWidget {
   MyDogruYanlisAnswerBox(
      {this.val=false,super.key,
      required this.color1,
      required this.color2,
        required this.onChangedFunc
     // required this.changeBorder,
     // required this.borderColor1,
       // required this.borderColor2,
     });
  final Color color1;
  final Color color2;
  bool val;
  final Function onChangedFunc;
  //final Function changeBorder;
  //final borderColor1;
 // final borderColor2;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MyDogruYanlisAnswerBoxState();
}

class _MyDogruYanlisAnswerBoxState
    extends ConsumerState<MyDogruYanlisAnswerBox> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.color1,
                    borderRadius: BorderRadius.circular(8),
                    // border: Border.all(color: widget.borderColor1,width: 4),
                  ),
                  height: 200,
                  width: 100,
                  child: TextButton(
                    onPressed: () {
                      //  widget.changeBorder(0);
                    },
                    child: Text("Doğru", style: TextStyle(color: Colors.white)),
                  ),
                )),
            const SizedBox(
              width: 5,
            ),
            Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.color2,
                    borderRadius: BorderRadius.circular(8),
                    // border: Border.all(color: widget.borderColor2,width: 4),
                  ),
                  height: 200,
                  width: 100,
                  child: TextButton(
                    onPressed: () {
                      // widget.changeBorder(1);
                    },
                    child: Text("Yanlış", style: TextStyle(color: Colors.white)),
                  ),
                )),
          ],
        ),
      ),Positioned(top: 0,right: 0,child: Switch(activeColor: Colors.black87,value: widget.val, onChanged: (value) {
        setState(() {
          widget.val=value;
        });
      },),),],
    );
    ;
  }
}
