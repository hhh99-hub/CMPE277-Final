import 'package:flutter/material.dart';
//import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class TranslateServiceScreen extends StatefulWidget {
  @override
  _TranslateServiceScreenState createState() => _TranslateServiceScreenState();
}

class _TranslateServiceScreenState extends State<TranslateServiceScreen> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _translatedtextController=TextEditingController();
  //final FlutterTts _flutterTts = FlutterTts();
  String _selectedLanguage = 'es';
  final List<String> _languages = ['es', 'pt', 'de', 'fr'];

  Future<void> _translateText() async {
    var response = await http.post(
      Uri.parse('http://172.208.50.13:8080/translate-text'),
      //headers: {'Cookie': 'Cookie_2=value'},
      body: {
        'language': _selectedLanguage,
        'text': _textController.text,
      },
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var translatedText = data[0]['translations'][0]['text'];
      //_speak(translatedText);
      _translatedtextController.text = translatedText;  // Optionally update the text field with the translated text
    } else {
      print('Failed to translate text: ${response.statusCode}');
    }
  }

  // Future<void> _speak(String text) async {
  //   await _flutterTts.setLanguage(_selectedLanguage);
  //   await _flutterTts.speak(text);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Translate Service"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Enter text to translate',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedLanguage,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedLanguage = newValue;
                  });
                }
              },
              items: _languages.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.toUpperCase()),
                );
              }).toList(),
            ),
        Padding(
          padding: const EdgeInsets.all(16.0),  // Adjust the padding as needed
          child: ElevatedButton(
              onPressed: _translateText,
              child: Text('Translate',style: TextStyle(color: Colors.black)),
            ),),
            TextField(
              controller: _translatedtextController,
              decoration: InputDecoration(
                labelText: 'Translated text will be here',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
