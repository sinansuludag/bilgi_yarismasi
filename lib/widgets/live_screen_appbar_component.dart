import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiveScreenAppBarComponent extends ConsumerWidget {
  const LiveScreenAppBarComponent({Key? key,required this.isItAppbar}) : super(key: key);
  final bool isItAppbar;
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Expanded(
      child: ListTile(
        title: Container(
          margin: const EdgeInsets.only(left: 25),
          width: 160,
          height: 50,
          child:isItAppbar ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Image.asset("assets/images/options_6193980.png")),
              ),
              const Expanded(
                child: Text("Quiz",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white)),
              ),
            ],
          ) : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Image.asset("assets/images/answer_3261305.png")),
              ),
              const Expanded(
                child: Text("Doğru/Yanlış",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white)),
              ),
            ],
          ) ,
        ),
        leading: const Text("1/1",
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        trailing: TextButton(
            onPressed: () {},
            child: Icon(
              Icons.menu,
              color: Colors.indigo.shade900,
              size: 30,
            )),
      ),
    );
  }
}
