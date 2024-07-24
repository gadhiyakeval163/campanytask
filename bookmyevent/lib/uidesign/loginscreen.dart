import 'dart:async';
import 'dart:convert';

import 'package:bookmyevent/uidesign/bottomnavigationscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyLoginScreen extends StatefulWidget {
  @override
  _MyLoginScreenState createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  final TextEditingController _codeController = TextEditingController();
  int _countdown = 20;
  Timer? _timer;
  List<dynamic> _countries = [];
  List<dynamic> _cities = [];
  String _selectedCountry = 'India';
  String _selectedCity = 'Mumbai';

  @override
  void initState() {
    super.initState();
    _startCountdown();
    _fetchCountries();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _codeController.dispose();
    super.dispose();
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _countdown--;
        if (_countdown == 0) {
          _timer?.cancel();
        }
      });
    });
  }

  Future<void> _fetchCountries() async {
    final response = await http.get(Uri.parse('https://www.bme.seawindsolution.ae/api/f/country'));
    if (response.statusCode == 200) {
      final List<dynamic> countries = json.decode(response.body);
      setState(() {
        _countries = countries;
        _selectedCountry = 'India'; // Pre-select India
        _fetchCities(_getCountryId(_selectedCountry));
      });
    } else {
      // Handle error
      print('Failed to load countries');
    }
  }

  Future<void> _fetchCities(String countryId) async {
    final response = await http.get(Uri.parse('https://www.bme.seawindsolution.ae/api/f/city/$countryId'));
    if (response.statusCode == 200) {
      final List<dynamic> cities = json.decode(response.body);
      setState(() {
        _cities = cities;
        _selectedCity = 'Mumbai'; // Pre-select Mumbai
      });
    } else {
      // Handle error
      print('Failed to load cities');
    }
  }

  String _getCountryId(String countryName) {
    for (var country in _countries) {
      if (country['name'] == countryName) {
        return country['id'].toString();
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Verification'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "We've sent you the verification \ncode on +91 12345 12345",
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            DropdownButton<String>(
              value: _selectedCountry,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCountry = newValue!;
                  _fetchCities(_getCountryId(_selectedCountry));
                });
              },
              items: _countries.map<DropdownMenuItem<String>>((dynamic value) {
                return DropdownMenuItem<String>(
                  value: value['name'],
                  child: Text(value['name']),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            DropdownButton<String>(
              value: _selectedCity,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCity = newValue!;
                });
              },
              items: _cities.map<DropdownMenuItem<String>>((dynamic value) {
                return DropdownMenuItem<String>(
                  value: value['name'],
                  child: Text(value['name']),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCodeInput(5),
                _buildCodeInput(5),
                _buildCodeInput(0),
                _buildCodeInput(0),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyBottomNavigation()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                textStyle: TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text('CONTINUE'),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Re-send code in ${_countdown > 0 ? _countdown : "0:20"}',
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(height: 30.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                padding: EdgeInsets.all(10.0),
                children: List.generate(12, (index) {
                  return _buildNumberButton(index + 1);
                }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNumberButton(0),
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    // TODO: Implement backspace functionality
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeInput(int? value) {
    return SizedBox(
      width: 45.0,
      height: 45.0,
      child: TextField(
        controller: _codeController,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: value != null ? value.toString() : '',
        ),
        onChanged: (text) {
          if (text.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  Widget _buildNumberButton(int number) {
    return ElevatedButton(
      onPressed: () {
        _codeController.text += number.toString();
        FocusScope.of(context).nextFocus();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.all(16.0),
        textStyle: TextStyle(fontSize: 18.0),
      ),
      child: Text(
        number == 0 ? '0' : number.toString(),
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
