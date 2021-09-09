import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Add.dart';
import 'Favorite.dart';
import 'HomePage.dart';
import 'MyProfile.dart';
import 'SearchPage.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentindex=0;
  final List<Widget> _children= [
    HomePage(),
    SearchPage(),
    Favorite(),
    MyProfile(),
  ];
  void onTapped(int index){
    setState(() {
      _currentindex=index;
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: _children[_currentindex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: _currentindex,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.amber[800],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "My ads",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: "My account",
          ),
        ],
      ),
    );



  }
}