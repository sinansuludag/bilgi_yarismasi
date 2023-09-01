import 'package:flutter/material.dart';

class MyLeaderBoardPage extends StatefulWidget {
  const MyLeaderBoardPage({Key? key}) : super(key: key);

  @override
  State<MyLeaderBoardPage> createState() => _MyLeaderBoardPageState();
}

class _MyLeaderBoardPageState extends State<MyLeaderBoardPage> {
  void _showBottomSheet(BuildContext context) {
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
                  Image.asset(
                    "assets/images/icons8-cancel-48.png",
                  ),
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
                onPressed: () =>
                    Navigator.pushNamed(context, "/MyLeaderBoardPage"),
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
                    minimumSize: Size(250, 50),
                    backgroundColor: Colors.indigo.shade900),
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
            backgroundColor: Colors.indigo.shade300,
            title: Text("Soru: 1/4",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            centerTitle: true,
            actions: [
              TextButton(
                  onPressed: () {},
                  child: Container(
                    height: 35,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white, // Kenar çizgisi rengi
                        width: 2.0, // Kenar çizgisi kalınlığı
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Çık",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 1,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            "Zeynep",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          leading: Text(
                            "1",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                          trailing: Text(
                            "2345",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  "...",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                      color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 210),
                    child: ListTile(
                      title: Text(
                        "Sen",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: Text("7",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                      trailing: Text(
                        "1254",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, "/MyLiveSessionPage"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo.shade900,
                        minimumSize: Size(250, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                    child: Text(
                      "Devam et",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
