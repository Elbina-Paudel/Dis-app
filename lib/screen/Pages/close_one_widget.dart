import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../helper/app_toast.dart';
import '../contacts/model/close_contact_model.dart';
import '../contacts/service/close_contact_service.dart';

class CloseOneWidget extends StatefulWidget {
  const CloseOneWidget({super.key});

  @override
  State<CloseOneWidget> createState() => _CloseOneWidgetState();
}

class _CloseOneWidgetState extends State<CloseOneWidget> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _number = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Gap(16),
        TextFormField(
          controller: _username,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
            hintText: "Username",
          ),
        ),
        const Gap(16),
        TextFormField(
          controller: _number,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: "Number",
          ),
        ),
        const Gap(16),
        ElevatedButton(
          onPressed: () async {
            String username = _username.text.trim();
            int number = int.parse(_number.text);
            var data = CloseContactModel(
              username: username,
              number: number,
            );
            await CloseContactService().addContact(data);

            _username.clear();
            _number.clear();

            appToast("Contact Added Successfully");
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
