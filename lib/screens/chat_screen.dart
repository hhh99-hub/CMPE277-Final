import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String _locationPreference = 'Beaches';
  String _ambiencePreference = 'Calm';
  String _travelTypePreference = 'Bachelor';
  String _numberOfPeople = '';
  String _numberOfDays = '';
  String _place = '';
  List<String> _apiResults = [];

  Future<void> _submitForm() async {
    var url = Uri.parse('http://172.208.50.13:8080/itinerary-create');
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "destinationType": _locationPreference,
        "ambience": _ambiencePreference,
        "suitability": _travelTypePreference,
        "numberOfPeople": _numberOfPeople,
        "numberOfDays": _numberOfDays,
        "place": _place,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        _apiResults = [response.body];
        print(response
            .body); // Store the whole response as a single entry in the list
      });
    } else {
      // Handle error or show an error message
      print("Failed to load data: ${response.statusCode}");
    }
  }

  Widget _buildItineraryList() {
    return ListView.builder(
      itemCount: _apiResults.length,
      // Should be 1 if only one response is received
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(_apiResults[index], style: TextStyle(fontSize: 16)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Preferences Form"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          // Your form elements here as list tiles or custom widgets
          ListTile(
            title: const Text('Beaches'),
            leading: Radio<String>(
              activeColor: Colors.black,
              value: 'Beaches',
              groupValue: _locationPreference,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() => _locationPreference = value);
                }
              },
            ),
          ),
          ListTile(
            title: const Text('Mountains'),
            leading: Radio<String>(
              activeColor: Colors.black,
              value: 'Mountains',
              groupValue: _locationPreference,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() => _locationPreference = value);
                }
              },
            ),
          ),
          ListTile(
            title: const Text('Calm'),
            leading: Radio<String>(
              activeColor: Colors.black,
              value: 'Calm',
              groupValue: _ambiencePreference,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() => _ambiencePreference = value);
                }
              },
            ),
          ),
          ListTile(
            title: const Text('Loud'),
            leading: Radio<String>(
              activeColor: Colors.black,
              value: 'Loud',
              groupValue: _ambiencePreference,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() => _ambiencePreference = value);
                }
              },
            ),
          ),
          ListTile(
            title: const Text('Bachelor'),
            leading: Radio<String>(
              activeColor: Colors.black,
              value: 'Bachelor',
              groupValue: _travelTypePreference,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() => _travelTypePreference = value);
                }
              },
            ),
          ),
          ListTile(
            title: const Text('Family'),
            leading: Radio<String>(activeColor: Colors.black,
              value: 'Family',
              groupValue: _travelTypePreference,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() => _travelTypePreference = value);
                }
              },
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Number of people',
            ),
            onChanged: (value) => _numberOfPeople = value,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Number of days',
            ),
            onChanged: (value) => _numberOfDays = value,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Place',
            ),
            onChanged: (value) => _place = value,
          ),
    Padding(
    padding: const EdgeInsets.all(16.0),  // Adjust the padding as needed
    child: ElevatedButton(
            onPressed: _submitForm,
            child: Text('Submit',style: TextStyle(color: Colors.black)),
            style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(theme.primaryColor), // Button color
          ),
          ),
    ),
          if (_apiResults.isNotEmpty) ..._apiResults.map((result) =>
              Text(result)).toList(),
        ],
      ),
    );
  }
}
