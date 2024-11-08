import 'package:flutter/material.dart';

import '../../utils/slider.dart';
import '../home_screen.dart';
import 'widgets/quote_widget.dart';

class HomeMainScreen extends StatelessWidget {
  const HomeMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        QuotesWidget(),
        NewsSlider(),
        Expanded(
          child: Center(
            child: Text(
              'Welcome to Intelliaid',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF673AB7),
              ),
            ),
          ),
        ),
        EmergencyButtons(),
        SizedBox(height: 20),
        EmergencyRedButton(),
      ],
    );
  }
}
