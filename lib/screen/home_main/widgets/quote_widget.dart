import 'dart:async';
import 'package:flutter/material.dart';

class QuotesWidget extends StatefulWidget {
  const QuotesWidget({super.key});

  @override
  QuotesWidgetState createState() =>
      QuotesWidgetState(); // Make the state class public
}

class QuotesWidgetState extends State<QuotesWidget> {
  final List<String> _quotes = [
    "Preparedness is the only way we can combat a natural disaster.!",
    "A community that is prepared can overcome even the most devastating disaster.",
    "Every day is a new beginning.",
    "By failing to prepare, you are preparing to fail.",
    "Hope for the best, but prepare for the worst.",
    "Disaster preparedness should be a way of life, not a one-time event.",
    "In times of peace, prepare for war. In times of safety, prepare for disaster.",
    "Strength doesn’t come from what you can do. It comes from overcoming the things you thought you couldn’t.",
    "We cannot stop natural disasters, but we can arm ourselves with knowledge: so many lives wouldn’t have to be lost if there was enough disaster preparedness.",
    "The best way to predict the future is to create it."
  ];
  int _currentQuoteIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startQuoteRotation();
  }

  void _startQuoteRotation() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      setState(() {
        _currentQuoteIndex = (_currentQuoteIndex + 1) % _quotes.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          _quotes[_currentQuoteIndex],
          style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
