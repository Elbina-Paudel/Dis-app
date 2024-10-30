import 'package:disaster_app/screen/contacts/sos_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../helper/url_helper.dart';
import 'add_emergency_contact.dart';
import 'utils/emergency_contact.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                emergencyContact[index]['title'],
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                emergencyContact[index]['number'],
              ),
              trailing: IconButton(
                onPressed: () => callNumber(emergencyContact[index]['number']),
                icon: const Icon(Icons.phone),
              ),
            ),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: emergencyContact.length,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Your SOS Contact",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            IconButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (context) => const AddEmergencyContact(),
              ),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const Gap(16.0),
        SosContactScreen(),
      ],
    );
  }
}
