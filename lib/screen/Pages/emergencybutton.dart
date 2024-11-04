import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_sms/flutter_sms.dart';

class EmergencyButton extends StatefulWidget {
  @override
  _EmergencyButtonState createState() => _EmergencyButtonState();
}

class _EmergencyButtonState extends State<EmergencyButton> {
  final String accountSid = 'AC8503dfbfd9704e6845d9b4b5efb90de0';
  final String authToken = '0d07e55d7f9814ce5c71711c54860287';
  final String twilioNumber = '+19045744934';
  File? _image;
  final List<String> emergencyContacts = [
    "+1234567890", // Replace with actual contact numbers
    "+0987654321"
  ];
  
  final picker = ImagePicker();

  Future<void> _captureImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print("No image selected.");
    }
  }

  Future<String?> _uploadImageToTwilio(File image) async {
    final Uri url = Uri.parse('https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages/Media.json');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Basic ${base64Encode(utf8.encode('$accountSid:$authToken'))}',
        'Content-Type': 'multipart/form-data',
      },
      body: {
        'MediaUrl': image.path,
      },
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['uri'];
    } else {
      print("Failed to upload image: ${response.statusCode}");
      print(response.body);
      return null;
    }
  }

  Future<void> _sendEmergencySMS(String imageUrl) async {
    String message = "Emergency! I need help. My photo is here: $imageUrl";

    try {
      String result = await sendSMS(message: message, recipients: emergencyContacts);
      print(result);
    } catch (error) {
      print("Failed to send SMS: $error");
    }
  }

  Future<void> _handleEmergency() async {
    await _captureImage();

    if (_image != null) {
      String? imageUrl = await _uploadImageToTwilio(_image!);

      if (imageUrl != null) {
        await _sendEmergencySMS(imageUrl);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Emergency SMS sent!")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to upload image")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Image capture failed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Emergency Button")),
      body: Center(
        child: ElevatedButton(
          onPressed: _handleEmergency,
          child: Text("Send Emergency Alert"),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
