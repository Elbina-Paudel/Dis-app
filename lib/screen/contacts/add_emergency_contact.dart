import 'package:disaster_app/screen/contacts/model/emergency_contact_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'service/emergency_contact_service.dart';

class AddEmergencyContact extends StatefulWidget {
  const AddEmergencyContact({super.key});

  @override
  State<AddEmergencyContact> createState() => _AddEmergencyContactState();
}

class _AddEmergencyContactState extends State<AddEmergencyContact> {
  final EmergencyContactService _emergencyContactService =
      EmergencyContactService();

  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final TextEditingController _address = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Form(
        child: ListView(
          children: [
            const Center(
              child: Text(
                "Add Contact Details",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Gap(24),
            TextFormField(
              controller: _fullname,
              decoration: const InputDecoration(
                hintText: "Enter Fullname",
                labelText: "Fullname",
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(24),
            TextFormField(
              controller: _number,
              decoration: const InputDecoration(
                hintText: "Enter Contact",
                labelText: "Contact",
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(24),
            TextFormField(
              controller: _address,
              decoration: const InputDecoration(
                hintText: "Address",
                labelText: "Enter Address",
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(32),
            ElevatedButton(
              onPressed: () async {
                // String fullname = _fullname.text.trim();
                // int number = int.parse(_number.text);
                // String address = _address.text;
                var data = EmergencyContactModel();
                await _emergencyContactService.addContact(data);
              },
              child: const Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}
