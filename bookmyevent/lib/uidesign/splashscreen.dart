import 'dart:async';

import 'package:bookmyevent/uidesign/loginscreen.dart';
import 'package:flutter/material.dart';

class MySplaceScreen extends StatefulWidget {
  const MySplaceScreen({super.key});

  @override
  State<MySplaceScreen> createState() => _MySplaceScreenState();
}

class _MySplaceScreenState extends State<MySplaceScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyLoginScreen(),
              ),
            ));
  }

  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.airplane_ticket),
            SizedBox(height: 20),
            Text(
              'Book My Event',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
