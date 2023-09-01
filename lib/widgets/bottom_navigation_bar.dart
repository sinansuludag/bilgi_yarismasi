import 'package:bilgi_barismasi/pages/create_screen_page.dart';
import 'package:bilgi_barismasi/pages/home_page.dart';
import 'package:bilgi_barismasi/pages/profil_screen_page.dart';
import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int currentIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    const MyCreateScreenPage(),
    const MyProfilScreenPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade300,
      bottomNavigationBar: myBottomNavigationBar(),
      body: pages[currentIndex],
    );
  }

  BottomNavigationBar myBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.indigo.shade200,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black87,
      unselectedItemColor: Colors.black45,
      items: [
        myBottomNavigationBarItem(Icons.home, "Anasayfa"),
        myBottomNavigationBarItem(Icons.add_box_outlined, "Oluştur"),
        myBottomNavigationBarItem(
          Icons.account_circle_sharp,
          "Profil",
        ),
      ],
      currentIndex: currentIndex,
      onTap: onItemTapped,
    );
  }

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  BottomNavigationBarItem myBottomNavigationBarItem(
      IconData icon, String label) {
    return BottomNavigationBarItem(icon: Icon(icon), label: label);
  }
}
