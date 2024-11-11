import 'package:disaster_app/screen/caller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/viewmap.dart';

class EmergencyBtnScreen extends StatelessWidget {
  const EmergencyBtnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        "title": "Ambulance",
        "image": "assets/ambulance.png",
        "number": "102",
      },
      {
        "title": "Police",
        "image": "assets/security-guard.png",
        "number": "100",
      },
      {
        "title": "Fire Brigade",
        "image": "assets/truck.png",
        "number": "101",
      },
      {
        "title": "Close One",
        "image": "assets/phone.png",
        "number": "+9779846091133",
      },
      {
        "title": "View Map",
        "image": "assets/location.png",
      },
    ];
    return SizedBox(
      height: 380,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          mainAxisSpacing: 16,
          crossAxisSpacing: 8,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return InkWell(
            onTap: () => item["title"] == "View Map"
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MapView(),
                    ),
                  )
                : Caller.callNumber(item['number']),
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("${item['image']}"),
                  const Gap(8),
                  Text(
                    "${item['title']}",
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
