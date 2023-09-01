import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          title: Text(
            "Soru Kitapçıklarım",
            style: TextStyle(
                fontFamily: "DancingScript",
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Colors.indigo.shade900),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.indigo.shade200,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => showBottomSheet(context),
                  onLongPress: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      actions: [
                        Column(
                          children: [
                            Text("Soru kitapçığı silinsin mi ?",
                                style: TextStyle(
                                    color: Colors.indigo.shade500,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                myElevatedButton(context,"İptal",(){Navigator.pop(context);}),
                                SizedBox(
                                  width: 8,
                                ),
                                myElevatedButton(context, "Sil", (){}),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                          width: 20,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    "Başlık",
                                    style: TextStyle(
                                        color: Colors.indigo,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  leading: Container(
                                    width: 70,
                                    height: 70,
                                    color: Colors.indigo.shade100,
                                  ),
                                  subtitle: Text("10 soru",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.indigo.shade500,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton myElevatedButton(BuildContext context,String text,Function function) {
    return ElevatedButton(
      onPressed: () => function(),
      child: Text(
        text,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo.shade500,
      ),
    );
  }
}
