
import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  final String text;
   MyDivider({Key? key,  this.text=''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child:  Padding(
        padding: EdgeInsets.only(right: 70, left: 70),
        child: Row(
          children: [
            Expanded(
              child: Divider(
                color: Colors.black,
                thickness: 1.0,
                height: 20.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child:  Text(text,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Expanded(
              child: Divider(
                color: Colors.black,
                thickness: 1.0,
                height: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
