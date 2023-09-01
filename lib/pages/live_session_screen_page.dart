import 'package:flutter/material.dart';

class MyLiveSessionPage extends StatefulWidget {
  const MyLiveSessionPage({Key? key}) : super(key: key);

  @override
  State<MyLiveSessionPage> createState() => _MyLiveSessionPageState();
}

class _MyLiveSessionPageState extends State<MyLiveSessionPage> {
  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.indigo.shade300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 150,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/icons8-cancel-48.png",),
                  Text(
                    "Yanlış",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 25,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, "/MyLeaderBoardPage"),
                child: Text(
                  "Devam et",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: Size(250, 50),backgroundColor: Colors.indigo.shade900),

              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo.shade300,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.indigo.shade200,
          actions: [
            myActions(context),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              myLiveSessionPicture(),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.indigo.shade200,
                  ),
                  height: 85,
                  width: double.infinity,
                ),
              ),
              Row(
                children: [
                  myLiveSessionAnswerBox(
                    Colors.blue.shade900,
                    "Doğru",
                    () {
                      Navigator.pushNamed(context, "/MyLeaderBoardPage");
                    },
                  ),
                  myLiveSessionAnswerBox(Colors.red, "Yanlış", () {
                    showBottomSheet(context);
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded myLiveSessionAnswerBox(Color color, String text, Function function) {
    return Expanded(
      child: TextButton(
        onPressed: () => function(),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: color),
          width: 185,
          height: 230,
          child: Center(
              child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
          )),
        ),
      ),
    );
  }

  Padding myLiveSessionPicture() {
    return Padding(
      padding: const EdgeInsets.only(right: 5, left: 5, top: 5),
      child: Container(
        height: 210,
        width: double.infinity,
        color: Colors.indigo.shade100,
        child: Center(),
      ),
    );
  }

  Expanded myActions(BuildContext context) {
    return Expanded(
      child: ListTile(
        title: Container(
          margin: EdgeInsets.only(left: 25),
          width: 160,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/answer_3261305.png"),
              ),
              const Expanded(
                child: Text("Doğru/Yanlış",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white)),
              ),
            ],
          ),
        ),
        leading: Text("1/1",
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
