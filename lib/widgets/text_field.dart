import 'package:flutter/material.dart';

class MyTextFieldPage extends StatelessWidget {

  const MyTextFieldPage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                maxLines: 3,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                 focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.indigo.shade900),),
                  hintStyle: TextStyle(color: Colors.indigo,)
                ),
              ),
            ),

          ],
        ),
      ],
    );
  }
}
