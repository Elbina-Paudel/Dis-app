import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../helper/url_helper.dart';
import 'model/emergency_contact_model.dart';
import 'service/emergency_contact_service.dart';
import 'utils/emergency_contact.dart';

class SosContactScreen extends StatefulWidget {
  const SosContactScreen({super.key});

  @override
  State<SosContactScreen> createState() => _SosContactScreenState();
}

class _SosContactScreenState extends State<SosContactScreen> {
  final EmergencyContactService _emergencyContactService =
      EmergencyContactService();
  Future<void> openBox() async {
    await Hive.openBox<EmergencyContactModel>('emergencyContactBox');
  }

  @override
  void initState() {
    super.initState();
    openBox();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
          future: _emergencyContactService.getAllContact(),
          builder: (context, snapshot) {
            return ValueListenableBuilder(
                valueListenable:
                    Hive.box<EmergencyContactModel>('emergencyContactBox')
                        .listenable(),
                builder: (context, box, _) {
                  if (box.values.isEmpty) {
                    return const Text("Nothing found");
                  }
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      var contact = box.getAt(index);
                      return ListTile(
                        title: Text(
                          '${contact!.fullname}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          '${contact.fullname}',
                        ),
                        trailing: IconButton(
                          onPressed: () => callNumber('${contact.number}'),
                          icon: const Icon(Icons.phone),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: emergencyContact.length,
                  );
                });
          }),
    );
  }
}
