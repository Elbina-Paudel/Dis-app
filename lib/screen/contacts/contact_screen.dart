import 'package:disaster_app/screen/contacts/sos_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../helper/url_helper.dart';
import 'add_emergency_contact.dart';
import 'utils/emergency_contact.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Map<String, String>> emergencyContacts = [
    {'title': 'Ambulance', 'number': '102'},
    {'title': 'Police', 'number': '100'},
    {'title': 'Fire Brigade', 'number': '101'},
  ];

  // Adding three initial SOS contacts
  List<Map<String, String>> sosContacts = [
    {'title': 'Soni ', 'number': '9823572763'},
    {'title': 'Janny', 'number': '9876543211'},
    {'title': 'Sita', 'number': '9822334455'},
  ];

  void addSosContact(String name, String number) {
    setState(() {
      sosContacts.add({'title': name, 'number': number});
    });
  }

  void editContact(int index, String name, String number, bool isEmergencyContact) {
    setState(() {
      if (isEmergencyContact) {
        emergencyContacts[index] = {'title': name, 'number': number};
      } else {
        sosContacts[index] = {'title': name, 'number': number};
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Emergency contacts section with edit option
        Expanded(
          child: ListView.separated(
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
                    onPressed: () => callNumber(emergencyContacts[index]['number']!),
                    icon: const Icon(Icons.phone),
                  ),
                  IconButton(
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => EditContactForm(
                        contact: emergencyContacts[index],
                        onSave: (name, number) => editContact(index, name, number, true),
                      ),
                    ),
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: emergencyContacts.length,
          ),
        ),
        const Gap(16.0),

        // SOS Contacts section with add button
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
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (context) => AddEmergencyContactForm(onAdd: addSosContact),
              ),
              icon: const Icon(Icons.add),
            ),
          ],
        ),

        const Gap(16.0),

        // SOS Contacts list with edit option
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: sosContacts.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(sosContacts[index]['title']!),
              subtitle: Text(sosContacts[index]['number']!),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => callNumber(sosContacts[index]['number']!),
                    icon: const Icon(Icons.phone),
                  ),
                  IconButton(
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => EditContactForm(
                        contact: sosContacts[index],
                        onSave: (name, number) => editContact(index, name, number, false),
                      ),
                    ),
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Form for adding new SOS contact
class AddEmergencyContactForm extends StatelessWidget {
  final Function(String, String) onAdd;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  AddEmergencyContactForm({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Contact Name"),
          ),
          const Gap(16.0),
          TextField(
            controller: numberController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(labelText: "Phone Number"),
          ),
          const Gap(16.0),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text;
              final number = numberController.text;
              if (name.isNotEmpty && number.isNotEmpty) {
                onAdd(name, number);
                Navigator.pop(context); // Close modal after adding
              }
            },
            child: const Text("Add Contact"),
          ),
        ],
      ),
    );
  }
}

// Form for editing an existing contact
class EditContactForm extends StatelessWidget {
  final Map<String, String> contact;
  final Function(String, String) onSave;
  final TextEditingController nameController;
  final TextEditingController numberController;

  EditContactForm({required this.contact, required this.onSave})
      : nameController = TextEditingController(text: contact['title']),
        numberController = TextEditingController(text: contact['number']);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Edit Contact Name"),
          ),
          const Gap(16.0),
          TextField(
            controller: numberController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(labelText: "Edit Phone Number"),
          ),
          const Gap(16.0),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text;
              final number = numberController.text;
              if (name.isNotEmpty && number.isNotEmpty) {
                onSave(name, number);
                Navigator.pop(context); // Close modal after editing
              }
            },
            child: const Text("Save Changes"),
          ),
        ],
      ),
    );
  }
}

// Placeholder for the callNumber function
void callNumber(String number) {
  // Implement your functionality to initiate a phone call here
}
