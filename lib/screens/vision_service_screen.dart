import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class VisionServiceScreen extends StatefulWidget {
  @override
  _VisionServiceScreenState createState() => _VisionServiceScreenState();
}

class _VisionServiceScreenState extends State<VisionServiceScreen> {
  File? _image;
  final TextEditingController _textController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _scanImage() async {
    if (_image == null) return;
    try {
      var request = http.MultipartRequest('POST', Uri.parse('http://172.208.50.13:8080/translate-image'));
      request.files.add(await http.MultipartFile.fromPath('image', _image!.path));
      request.headers.addAll({
        'Cookie': 'Cookie_2=value'
      });
      var response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var jsonData = jsonDecode(responseBody); // Decode the JSON string
        if (jsonData.isNotEmpty) {
          var translations = jsonData[0]['translations'];
          if (translations.isNotEmpty) {
            String translatedText = translations[0]['text'];
            setState(() {
              _textController.text = translatedText; // Display the translated text
            });
          }
        }
      } else {
        _textController.text = 'Error: Server returned ${response.statusCode}';
      }
    } catch (e) {
      _textController.text = 'Error: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vision Service"),
      ),
      body: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),  // Adjust the padding as needed
              child:              ElevatedButton(
            onPressed: _pickImage,
            child: Text('Upload Image',style: TextStyle(color: Colors.black)),
          ),),
          if (_image != null) Image.file(_image!),

    Padding(
    padding: const EdgeInsets.all(8.0),  // Adjust the padding as needed
    child: ElevatedButton(
            onPressed: _scanImage,
            child: Text('Scan',style: TextStyle(color: Colors.black),
          ),),),
          TextField(
            controller: _textController,
            maxLines: null, // To handle multiline text
            decoration: InputDecoration(
              labelText: 'Detected Text',
            ),
          ),
        ],
      ),
    );
  }
}
