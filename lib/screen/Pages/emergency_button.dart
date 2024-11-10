import 'package:disaster_app/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class EmergencyButton extends StatelessWidget {
  const EmergencyButton({super.key});

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled.");
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permissions are denied.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permissions are permanently denied.");
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<XFile?> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.camera);
  }

  Future<String?> _uploadImageToFirebase(XFile image) async {
    try {
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child("emergency_images/${image.name}");
      final UploadTask uploadTask = storageRef.putFile(File(image.path));
      final TaskSnapshot downloadUrl = await uploadTask;
      return await downloadUrl.ref.getDownloadURL();
    } catch (e) {
      print("Failed to upload image: $e");
      return null;
    }
  }

  Future<void> sendMMS(String toNumber, String body, String? mediaUrl) async {
    final String accountSid = dotenv.env['TWILIO_ACCOUNT_SID'] ?? "";
    final String authToken = dotenv.env['TWILIO_AUTH_TOKEN'] ?? "";
    final String fromNumber = dotenv.env['TWILIO_PHONE_NUMBER'] ?? "";

    final Uri uri = Uri.parse(
        "https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages.json");

    final response = await http.post(
      uri,
      headers: {
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$accountSid:$authToken'))}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'From': fromNumber,
        'To': toNumber,
        'Body': body,
        if (mediaUrl != null) 'MediaUrl': mediaUrl,
      },
    );

    if (response.statusCode == 201) {
      print("Message sent successfully!");
    } else {
      print("Failed to send message: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> sendMessage() async {
      try {
        XFile? image = await _pickImage();
        Position position = await _getCurrentLocation();

        String messageBody =
            "I'm in danger! My current location is: https://maps.google.com/?q=${position.latitude},${position.longitude}";

        String? imageUrl;
        if (image != null) {
          imageUrl = await _uploadImageToFirebase(image);
        }

        // Send MMS with HTTP request
        await sendMMS(
          dotenv.env['TO_NUMBER'] ?? "",
          messageBody,
          imageUrl,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Emergency alert sent successfully!')),
        );
      } catch (e) {
        print("Error: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to send emergency alert.')),
        );
      }
    }

    return Scaffold(
      appBar: customAppBar(context, title: "Emergency Alert"),
      body: Center(
        child: ElevatedButton(
          onPressed: () => sendMessage(),
          child: const Text("Send Emergency Alert"),
        ),
      ),
    );
  }
}
