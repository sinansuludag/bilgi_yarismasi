import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar.dart';
import '../widgets/text_field.dart';

class MyDogruYanlisShapePage extends StatelessWidget {
  const MyDogruYanlisShapePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo.shade300,
        appBar: AppBar(
          backgroundColor: Colors.indigo.shade200,
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            myActions(context),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextButton(
                onPressed: () {},
                child: Container(
                  height: 170,
                  width: double.infinity,
                  color: Colors.indigo.shade300,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          color: Colors.indigo,
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Resim ekle",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 240),
                child: ElevatedButton(
                  onPressed: () { showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.indigo.shade100,
                      title: Text("Zaman sınırı",style: TextStyle(color: Colors.indigo.shade900),textAlign: TextAlign.center,),
                      content: Container(
                        height: 330,
                        child: Column(children: [
                          myTimeChooseWidget("5 sn","10 sn"),
                          myTimeChooseWidget("20 sn","30 sn"),
                          myTimeChooseWidget("60 sn","90 sn"),
                          myTimeChooseWidget("120 sn","180 sn"),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: ElevatedButton(onPressed:() {

                            }, child:Text("Bitti"),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo.shade300),),
                          )
                        ]),
                      ),
                    ),
                  );},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,

                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.watch_later_outlined),
                      Text(
                        "  20 sn",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Soruyu gir"),
                          content: MyTextFieldPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Soru eklemek için dokunun",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  // color: Colors.indigo.shade100,
                  decoration: BoxDecoration(
                      color: Colors.indigo.shade100,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              myAnswerBox(Colors.red, Colors.blue,context),
              Container(
                margin: EdgeInsets.only(left: 300),
                height: 70,
                width: 70,
                color: Colors.indigo,
                child: TextButton(onPressed: () {

                },child: Icon(Icons.add, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding myAnswerBox(Color color1, Color color2,BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              color: color1,
              borderRadius: BorderRadius.circular(8),
            ),
            height: 200,
            width: 100,
            child: TextButton(
              onPressed: () { showDialog(context: context, builder:(context) => AlertDialog(
                title: Text("Cevap ekle"),
                content: MyTextFieldPage(),
              ),);},
              child: Text("Cevap ekle", style: TextStyle(color: Colors.white)),
            ),
          )),
          SizedBox(
            width: 6,
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              color: color2,
              borderRadius: BorderRadius.circular(8),
            ),
            height: 200,
            width: 100,
            child: TextButton(
              onPressed: () { showDialog(context: context, builder:(context) => AlertDialog(
                title: Text("Cevap ekle"),
                content: MyTextFieldPage(),
              ),);},
              child: Text("Cevap ekle", style: TextStyle(color: Colors.white)),
            ),
          )),
        ],
      ),
    );
  }


  Row myTimeChooseWidget(String time1,time2) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {

            },
            child: Container(
              height: 50,
              width: 100,
              color: Colors.white,
              child: Container(margin:EdgeInsets.only(top: 15),child: Text(time1,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.center)),
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {

            },
            child: Container(
              height: 50,
              width: 100,
              color: Colors.white,
              child: Container(margin:EdgeInsets.only(top: 15),child: Text(time2,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.center)),
            ),
          ),
        )
      ],
    );
  }



  Expanded myActions(BuildContext context) {
    return Expanded(
      child: ListTile(
        title: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Container(
            color: Colors.indigo.shade400,
            width: 170,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/images/answer_3261305.png"),
                ),
                Expanded(
                  child: Text("Doğru/Yanlış",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white)),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.indigo.shade100,
                ),
              ],
            ),
          ),
        ),
        leading: TextButton(
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyBottomNavigationBar()),
                ),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.indigo.shade900,
              size: 30,
            )),
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
