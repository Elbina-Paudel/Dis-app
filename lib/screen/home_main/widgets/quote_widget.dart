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
    "Believe in yourself!",
    "Every day is a new beginning.",
    "Stay positive and happy.",
    "Work hard and never give up.",
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
