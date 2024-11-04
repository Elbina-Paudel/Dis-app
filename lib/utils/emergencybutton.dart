// import 'package:flutter/material.dart';
// import 'package:flutter_sms/flutter_sms.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:geolocator/geolocator.dart';

// class EmergencyButton extends StatefulWidget {
//   const EmergencyButton({super.key});

//   @override
//   _EmergencyButtonState createState() => _EmergencyButtonState();
// }

// class _EmergencyButtonState extends State<EmergencyButton> {
//   String? imagePath;

//   Future<void> sendSms(
//       String message, List<String> recipients, String? imagePath) async {
//     String result = await sendSMS(message: message, recipients: recipients)
//         .catchError((onError) {});

//     // Logic to handle sending the image if needed
//     if (imagePath != null) {
//       // You may need to implement this part based on your requirements
//     }
//   }

//   Future<void> captureImage() async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
//     if (photo != null) {
//       setState(() {
//         imagePath = photo.path;
//       });
//     }
//   }

//   Future<String?> getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     return '${position.latitude}, ${position.longitude}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Emergency Alert'),
//         backgroundColor: Colors.red,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () async {
//                 // Capture an image first
//                 await captureImage();

//                 // Get the current location
//                 String? location = await getCurrentLocation();

//                 // Send SMS with location and image path
//                 if (location != null) {
//                   String message =
//                       "This is an emergency alert. Please respond immediately! Location: $location";
//                   sendSms(
//                     message,
//                     ["+9779846091133"], // Replace with the numbers you need
//                     imagePath,
//                   );
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 padding: const EdgeInsets.symmetric(vertical: 16.0),
//                 shadowColor: Colors.redAccent,
//                 elevation: 5,
//               ),
//               child: const Text(
//                 'Send Emergency SMS',
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//             const SizedBox(
//                 height: 20), // Spacing between button and local bodies
//             const Text(
//               'Local Bodies Registered with Rescue Team:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10), // Spacing between text and list
//             Column(
//               children: const [
//                 Text('1. Local Body A'),
//                 Text('2. Local Body B'),
//                 Text('3. Local Body C'),
//                 Text('4. Local Body D'),
//                 Text('5. Local Body E'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
