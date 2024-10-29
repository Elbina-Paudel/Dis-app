import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Close Contacts',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text('HARI SHARMA'),
            subtitle: Text('Phone: 123-456-7890'),
          ),
          ListTile(
            title: Text('RAM DHAKAL'),
            subtitle: Text('Phone: 098-765-4321'),
          ),
          ListTile(
            title: Text('SITA SHARMA'),
            subtitle: Text('Phone: 456-789-0123'),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Emergency Contacts',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text('Ambulance'),
            subtitle: Text('Phone: 102'),
          ),
          ListTile(
            title: Text('Fire Brigade'),
            subtitle: Text('Phone: 101'),
          ),
          ListTile(
            title: Text('Police'),
            subtitle: Text('Phone: 100'),
          ),
          ListTile(
            title: Text('Rescue Services'),
            subtitle: Text('Phone: 103'),
          ),
        ],
      ),
    );
  }
}
