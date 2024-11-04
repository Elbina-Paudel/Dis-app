import 'package:disaster_app/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class EmergencyButton extends StatelessWidget {
  const EmergencyButton({super.key});

  @override
  Widget build(BuildContext context) {
    final String accountSid = dotenv.env['TWILIO_ACCOUNT_SID'] ?? "";
    final String authToken = dotenv.env['TWILIO_AUTH_TOKEN'] ?? "";
    final String fromNumber = dotenv.env['TWILIO_PHONE_NUMBER'] ?? "";
    final TwilioFlutter twilioFlutter = TwilioFlutter(
      accountSid: accountSid,
      authToken: authToken,
      twilioNumber: fromNumber,
    );

    void sendMessage() async {
      twilioFlutter.sendSMS(
        toNumber: dotenv.env['TO_NUMBER'] ?? "",
        messageBody: "This is testing",
      );
      TwilioResponse response = await twilioFlutter.sendWhatsApp(
        toNumber: dotenv.env['TO_NUMBER'] ?? "",
        messageBody: 'hello world',
      );
    }

    return Scaffold(
      appBar: customAppBar(context, title: "Emergency Alert"),
      body: ElevatedButton(
        onPressed: () => sendMessage(),
        child: const Text("Click Me!"),
      ),
    );
  }
}
