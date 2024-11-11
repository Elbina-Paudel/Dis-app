import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/slider.dart';
import '../emergency_btn_screen.dart';
import '../home_screen.dart';
import 'widgets/quote_widget.dart';

class HomeMainScreen extends StatelessWidget {
  const HomeMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        QuotesWidget(),
        Text(
          'Emergency Contacts',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xffbf592b),
          ),
        ),
        Gap(16),
        EmergencyBtnScreen(),
        Gap(16),
        Text(
          'Latest News',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xffbf592b),
          ),
        ),
        NewsSlider(),
        SizedBox(height: 20),
        EmergencyRedButton(),
      ],
    );
  }
}
