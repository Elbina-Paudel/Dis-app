import 'package:flutter/material.dart';

import '../Pages/emergency_button.dart';

class EmergencyRedButton extends StatelessWidget {
  const EmergencyRedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const EmergencyButton(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shadowColor: Colors.redAccent,
            elevation: 5,
          ),
          child: const Text(
            'Emergency Alert',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
