import 'package:bookmyevent/uidesign/homescreen.dart';
import 'package:bookmyevent/uidesign/profilescreen.dart';
import 'package:flutter/material.dart';

class MyBottomNavigation extends StatefulWidget {
  const MyBottomNavigation({super.key});

  @override
  State<MyBottomNavigation> createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation> {
  int myIndex = 4;
  List<Widget> myWiget = [
    MyHomeScreen(
      title: '',
    ),
    MyProfileScreen(title: '',),
  ];
  @override
  Widget build(BuildContext context) {
    var bottomNavigationBar = BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.brown,
        // showSelectedLabels: false,
        showUnselectedLabels: true,
        onTap: (value) {
          setState(() {
            print(value);
            myIndex = value;
            print(myIndex);
          });
        },
        currentIndex: myIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available_outlined),
            label: 'Event',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'List Show',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      );
    return Scaffold(
      body: Center(
        child: myWiget[myIndex],
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
