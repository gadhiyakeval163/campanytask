import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyProfileScreen extends StatefulWidget {
  MyProfileScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  List<dynamic> _sliderData = [];

  @override
  void initState() {
    super.initState();
    _fetchSliderData();
  }

  Future<void> _fetchSliderData() async {
    final response = await http.get(Uri.parse('https://www.bme.seawindsolution.ae/api/f/slider'));
    if (response.statusCode == 200) {
      final List<dynamic> sliderData = json.decode(response.body);
      setState(() {
        _sliderData = sliderData;
      });
    } else {
      // Handle error
      print('Failed to load slider data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text('Sign In'),
            ),
            SizedBox(height: 30),
            _buildSlider(),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('My Profile'),
                  ),
                  ListTile(
                    leading: Icon(Icons.list),
                    title: Text('List Your Show'),
                  ),
                  ListTile(
                    leading: Icon(Icons.percent),
                    title: Text('Offers'),
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text('About'),
                  ),
                  ListTile(
                    leading: Icon(Icons.call),
                    title: Text('Contact'),
                  ),
                  ListTile(
                    leading: Icon(Icons.question_mark),
                    title: Text('FAQ'),
                  ),
                  ListTile(
                    leading: Icon(Icons.support_agent),
                    title: Text('Help & Support'),
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Sign Out'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider() {
    if (_sliderData.isEmpty) {
      return CircularProgressIndicator();
    } else {
      return Container(
        height: 200.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _sliderData.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(_sliderData[index]['image_url']),
            );
          },
        ),
      );
    }
  }
}
