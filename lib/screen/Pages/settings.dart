import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _locationEnabled = false;
  bool _alertSoundEnabled = true;
  bool _autoUpdateEnabled = true;
  final Color switchActiveColor = const Color(0xffbf592b);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xffbf592b),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            "General",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _buildSettingOption(
            icon: Icons.notifications,
            title: 'Notifications',
            trailing: Switch(
              value: _notificationsEnabled,
              activeColor: switchActiveColor, 
              inactiveThumbColor: Colors.grey,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
          ),
          _buildSettingOption(
            icon: Icons.volume_up,
            title: 'Alert Sound',
            trailing: Switch(
              value: _alertSoundEnabled,
              activeColor: switchActiveColor, 
              inactiveThumbColor: Colors.grey,
              onChanged: (value) {
                setState(() {
                  _alertSoundEnabled = value;
                });
              },
            ),
          ),
          _buildSettingOption(
            icon: Icons.sync,
            title: 'Automatic Updates',
            trailing: Switch(
              value: _autoUpdateEnabled,
              activeColor: switchActiveColor, 
              inactiveThumbColor: Colors.grey,
              onChanged: (value) {
                setState(() {
                  _autoUpdateEnabled = value;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Location",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _buildSettingOption(
            icon: Icons.location_on,
            title: 'Location Services',
            trailing: Switch(
              value: _locationEnabled,
              activeColor: switchActiveColor, 
              inactiveThumbColor: Colors.grey,
              onChanged: (value) {
                setState(() {
                  _locationEnabled = value;
                });
                if (_locationEnabled) {
                  _showLocationInfo();
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Privacy",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _buildSettingOption(
            icon: Icons.privacy_tip,
            title: 'Privacy Policy',
            onTap: () {
              _showPrivacyPolicy(context);
            },
          ),
          const SizedBox(height: 20),
          const Text(
            "Support",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _buildSettingOption(
            icon: Icons.help,
            title: 'Help & FAQs',
            onTap: () {
              _showFAQ(context);
            },
          ),
        ],
      ),
    );
  }

  void _showLocationInfo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Location Services'),
          content: const Text(
              'Location services are enabled. You will receive location-based updates and alerts.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Privacy Policy'),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Privacy Policy',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Your privacy is important to us. This app collects only necessary data to provide you with disaster alerts and safety information.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Data Collection and Usage',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'We collect location data to provide you with location-based disaster alerts. Personal data, if any, is handled securely and used solely to enhance app performance and user experience.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Data Sharing',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'We do not share your personal data with third parties without your consent. All collected data is stored securely and used only to improve user safety and app functionality.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Your Rights',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'You have the right to request deletion of your data at any time by contacting support. We are committed to protecting your privacy and complying with all regulations.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'For any questions regarding your privacy, please contact us at: support@example.com.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
  onPressed: () {
    Navigator.of(context).pop();
  },
  style: TextButton.styleFrom(
    foregroundColor: Colors.white, // Text color
    backgroundColor: const Color(0xffbf592b), // Button background color
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Padding around the text
    shape: RoundedRectangleBorder( // Shape customization
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  child: const Text('Close'),
)

          ],
        );
      },
    );
  }

  void _showFAQ(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Help & FAQs'),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Frequently Asked Questions',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Q1: How does the app use my location?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'A: We use your location to send you disaster alerts specific to your area.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Q2: Can I disable notifications?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'A: Yes, you can disable notifications in the settings menu.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Q3: What data is collected by the app?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'A: The app collects location data and preferences to provide personalized alerts.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Q4: How often are updates provided?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'A: Updates are provided based on disaster notifications and safety changes in your region.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Q5: Can I customize alert sounds?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'A: Yes, alert sounds can be customized in the settings.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Q6: Does the app work offline?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'A: Limited functionality is available offline; location-based alerts require an internet connection.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Q7: How do I contact support?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'A: Contact support via the help section in the settings or email us at support@example.com.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Q8: What should I do if I receive a disaster alert?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'A: Follow the recommended safety protocols provided in the alert.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Q9: Can I provide feedback about the app?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'A: Yes, we welcome feedback! Please use the feedback form in the support section.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Q10: Is my personal information safe?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'A: Yes, we take data security seriously and comply with all privacy regulations.',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
      actions: [
  TextButton(
    onPressed: () {
      Navigator.of(context).pop();
    },
    style: TextButton.styleFrom(
      foregroundColor: Colors.white, // Text color
      backgroundColor: const Color(0xffbf592b), // Button background color
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Padding around the text
      shape: RoundedRectangleBorder( // Shape customization
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    child: const Text('Close'),
  ),
],

        );
      },
    );
  }

  Widget _buildSettingOption({
    required IconData icon,
    required String title,
    Widget? trailing,
    Function()? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xffbf592b)),
      title: Text(title),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
