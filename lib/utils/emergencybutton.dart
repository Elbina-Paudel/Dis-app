// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:sms_advanced/sms_advanced.dart';

// class EmergencyButton extends StatefulWidget {
//   const EmergencyButton({super.key});

//   @override
//   EmergencyButtonState createState() => EmergencyButtonState();
// }

// class EmergencyButtonState extends State<EmergencyButton> {
//   Future<void> _sendEmergencySms() async {
//     // Check for permissions
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }

//     // Proceed if permission is granted
//     if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
//       // Get the current location
//       Position? position;
//       try {
//         position = await Geolocator.getCurrentPosition(
//           locationSettings: const LocationSettings(
//             accuracy: LocationAccuracy.high,
//             distanceFilter: 10, // Meters
//           ),
//         );
//       } catch (e) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Failed to get location.')),
//           );
//         }
//         return;
//       }

//       // Format the message
//       String message =
//           'Emergency! I need help! Here is my location: https://maps.google.com/?q=${position.latitude},${position.longitude}';

//       // Define registered numbers
//       List<String> registeredNumbers = ['9846091133', '9823572763']; 

//       // Send SMS to each registered number
//       SmsSender sender = SmsSender();
//       for (String number in registeredNumbers) {
//         SmsMessage sms = SmsMessage(number, message);
//         sender.sendSms(sms);
//       }

//       // Show confirmation message
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Emergency SMS sent.')),
//         );
//       }
//     } else {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Location permission denied.')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Emergency'),
//         backgroundColor: Colors.red,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'In an emergency, press the button below to send your location to registered contacts.',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 20),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _sendEmergencySms,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
//               ),
//               child: const Text(
//                 'Send Emergency SMS',
//                 style: TextStyle(fontSize: 18, color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
