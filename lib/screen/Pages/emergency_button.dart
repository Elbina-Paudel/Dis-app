import 'package:disaster_app/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<void> sendWhatsAppMessage(String toNumber, String messageBody, String? mediaUrl) async {
    final String accountSid = dotenv.env['TWILIO_ACCOUNT_SID'] ?? "";
    final String authToken = dotenv.env['TWILIO_AUTH_TOKEN'] ?? "";
    final String fromNumber = dotenv.env['TWILIO_WHATSAPP_NUMBER'] ?? ""; // e.g., 'whatsapp:+1234567890'

    final Uri uri = Uri.parse('https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages.json');

    Map<String, String> headers = {
      'Authorization': 'Basic ' + base64Encode(utf8.encode('$accountSid:$authToken')),
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    Map<String, String> body = {
      'To': 'whatsapp:$toNumber',
      'From': fromNumber,
      'Body': messageBody,
    };

    if (mediaUrl != null) {
      body['MediaUrl'] = mediaUrl;
    }

    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 201) {
      print("Message sent successfully.");
    } else {
      print("Failed to send message: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> sendMessage() async {
      try {
        // Get the current location
        Position position = await _getCurrentLocation();
        String locationMessage =
            "I'm in danger! My current location is: https://maps.google.com/?q=${position.latitude},${position.longitude}";

        // Capture or select an image
        XFile? image = await _pickImage();
        
        // Here, you would typically upload the image to a cloud storage service and get a URL
        // For simplicity, let's assume `imageUrl` is a placeholder URL
        String? imageUrl = image?.path; // Replace this with your image upload logic if needed

        // Send WhatsApp message with location and optional image URL
        await sendWhatsAppMessage(
          dotenv.env['TO_NUMBER'] ?? "",
          "$locationMessage. Sending help with this photo.",
          imageUrl,
        );
      } catch (e) {
        print("Error: $e");
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
