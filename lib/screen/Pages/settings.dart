// settings_page.dart

import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _locationEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.deepPurple[300],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSettingOption(
            icon: Icons.account_circle,
            title: 'Account',
            onTap: () {
              // Navigate to Account settings page
            },
          ),
          _buildSettingOption(
            icon: Icons.notifications,
            title: 'Notifications',
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
          ),
          _buildSettingOption(
            icon: Icons.location_on,
            title: 'Location',
            trailing: Switch(
              value: _locationEnabled,
              onChanged: (value) {
                setState(() {
                  _locationEnabled = value;
                });
              },
            ),
          ),
          _buildSettingOption(
            icon: Icons.privacy_tip,
            title: 'Privacy',
            onTap: () {
              // Navigate to Privacy settings page
            },
          ),
          _buildSettingOption(
            icon: Icons.help,
            title: 'Help',
            onTap: () {
              // Navigate to Help section
            },
          ),
          _buildSettingOption(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              // Implement Logout functionality
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingOption({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(title),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
