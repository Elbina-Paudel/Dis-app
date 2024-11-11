import 'package:disaster_app/helper/url_helper.dart';
import 'package:disaster_app/screen/contacts/model/emergency_contact_model.dart';
import 'package:disaster_app/screen/contacts/service/emergency_contact_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'add_emergency_contact.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  ContactScreenState createState() => ContactScreenState();
}

class ContactScreenState extends State<ContactScreen> {
  List<Map<String, String>> emergencyContacts = [
    {'title': 'Ambulance', 'number': '102'},
    {'title': 'Police', 'number': '100'},
    {'title': 'Fire Brigade', 'number': '101'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Emergency Contacts Section
          const Text(
            "Emergency Contacts",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Gap(8),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                emergencyContacts[index]['title']!,
                style: const TextStyle(fontSize: 16),
              ),
              subtitle: Text(emergencyContacts[index]['number']!),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () =>
                        callNumber(emergencyContacts[index]['number']!),
                    icon: const Icon(Icons.phone),
                  ),
                  IconButton(
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const SizedBox.shrink();
                      },
                    ),
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: emergencyContacts.length,
          ),
          const Gap(24),

          // SOS Contacts Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Your SOS Contacts",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddEmergencyContact(),
                  ),
                ),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const Gap(8),
          FutureBuilder(
              future: EmergencyContactService().getAllContact(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<EmergencyContactModel> data = snapshot.data!;
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final items = data[index];
                        return ListTile(
                          title: Text(items.fullname ?? ""),
                          subtitle: Text('${items.number}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () => callNumber("${items.number}"),
                                icon: const Icon(Icons.phone),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.edit),
                              ),
                            ],
                          ),
                        );
                      });
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              })
        ],
      ),
    );
  }
}
