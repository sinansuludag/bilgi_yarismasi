import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget listeElemanlari(BuildContext context, int index) => Container(
        width: double.infinity,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 70,
                color: Colors.white,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " 1-Doğru/Yanlış ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                  Text(
                    " Sorular gösterilecek",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  )
                ],
              )
            ],
          ),
        ),
      );

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.85,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.indigo.shade300,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.indigo.shade100,
                        child: Center(
                          child: Text("Sorular",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50,
                                  fontFamily: "DancingScript")),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.indigo.shade200,
                      height: 70,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          " Kitapçığın başlığı burda yazacak",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 5,
                    endIndent: 10,
                    indent: 10,
                    color: Colors.white,
                  ),
                  myListTile(),
                  myListTile(),
                  myListTile(),
                  myListTile(),
                  myListTile(),
                  myListTile(),
                  myListTile(),
                  myListTile(),
                  myListTile(),
                  myListTile(),
                  myListTile(),
                  myListTile(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Padding myListTile() {
    return Padding(
      padding: const EdgeInsets.only(top: 4,left: 8,right: 8),
      child: Card(
        color: Colors.white70,
        child: ListTile(
          title: Text("1-Doğru/Yanlış"),
          subtitle:Text(("Sorulan soru burada gözükecek")),
          leading: Container(
            height: 60,
            width: 70,
            color: Colors.indigo.shade200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/images/icons8-gallery-64.png"),
            ),
          ),
        ),
      ),
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
              color: Colors.indigo.shade900,
            ),
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
                            Text(
                              "Soru kitapçığı silinsin mi ?",
                              style: TextStyle(
                                color: Colors.indigo.shade500,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                myElevatedButton(context, "İptal",
                                    () => Navigator.pop(context)),
                                SizedBox(
                                  width: 8,
                                ),
                                myElevatedButton(context, "Sil", () {}),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 90,
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
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  leading: Container(
                                    width: 70,
                                    height: 70,
                                    color: Colors.indigo.shade100,
                                  ),
                                  subtitle: Text(
                                    "10 soru",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.indigo.shade500,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton myElevatedButton(
      BuildContext context, String text, Function function) {
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
