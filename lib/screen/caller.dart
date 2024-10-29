import 'package:url_launcher/url_launcher.dart';

class Caller {
  // Method to launch the phone dialer
  static Future<void> callNumber(String number) async {
    final Uri launchUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $number';
    }
  }
}
