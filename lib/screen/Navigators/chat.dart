import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _sendMessage() {
    final userMessage = _controller.text;
    if (userMessage.isNotEmpty) {
      setState(() {
        _messages.add({'sender': 'User', 'text': userMessage});
        _controller.clear();
        _generateResponse(userMessage);
      });
    }
  }

  void _generateResponse(String userMessage) {
    String botResponse;

    // Responding to various types of disaster-related questions
    if (userMessage.toLowerCase().contains('earthquake')) {
      botResponse = 'In case of an earthquake, drop, cover, and hold on. Move away from windows and heavy objects.';
    } else if (userMessage.toLowerCase().contains('flood')) {
      botResponse = 'If there’s a flood, seek higher ground immediately. Avoid walking or driving through floodwaters.';
    } else if (userMessage.toLowerCase().contains('landslide')) {
      botResponse = 'Landslides are dangerous! Stay away from steep slopes and listen for unusual sounds like trees cracking.';
    } else if (userMessage.toLowerCase().contains('hurricane')) {
      botResponse = 'For hurricane preparedness, have an emergency kit, stay indoors, and listen to local authorities.';
    } else if (userMessage.toLowerCase().contains('wildfire')) {
      botResponse = 'In case of a wildfire, cover your nose and mouth, stay indoors if safe, and evacuate if ordered to.';
    } else if (userMessage.toLowerCase().contains('tornado')) {
      botResponse = 'If a tornado warning is issued, find shelter in a small, windowless room on the lowest floor.';
    } else if (userMessage.toLowerCase().contains('tsunami')) {
      botResponse = 'If you’re near the coast and feel an earthquake, move to higher ground immediately. A tsunami may follow.';
    } else if (userMessage.toLowerCase().contains('first aid')) {
      botResponse = 'For first aid in emergencies, remember basic steps: stop bleeding, immobilize injuries, and call for help.';
    } else if (userMessage.toLowerCase().contains('emergency kit')) {
      botResponse = 'An emergency kit should include water, food, flashlight, batteries, first aid, and important documents.';
    } else if (userMessage.toLowerCase().contains('evacuation')) {
      botResponse = 'Know your evacuation routes, pack a go-bag, and have a plan for family and pets during evacuations.';
    } else if (userMessage.toLowerCase().contains('fire safety')) {
      botResponse = 'For fire safety, install smoke alarms, have an escape plan, and never leave cooking unattended.';
    } else if (userMessage.toLowerCase().contains('lightning')) {
      botResponse = 'During lightning, stay indoors, avoid using electrical appliances, and avoid shelter under trees.';
    } else if (userMessage.toLowerCase().contains('heatwave')) {
      botResponse = 'In a heatwave, stay hydrated, avoid strenuous activities, and find air-conditioned spaces if possible.';
    } else if (userMessage.toLowerCase().contains('cold wave')) {
      botResponse = 'During a cold wave, dress in layers, cover extremities, and limit outdoor exposure to prevent hypothermia.';
    } else if (userMessage.toLowerCase().contains('pandemic') ||
               userMessage.toLowerCase().contains('virus')) {
      botResponse = 'During a pandemic, maintain hygiene, practice social distancing, and follow health authority guidelines.';
    } else if (userMessage.toLowerCase().contains('volcano')) {
      botResponse = 'If near a volcano, follow evacuation orders, wear masks for ash, and avoid low-lying areas.';
    } else if (userMessage.toLowerCase().contains('shelter')) {
      botResponse = 'Find shelter in a sturdy building during disasters. Avoid windows and stay in a safe, central area.';
    } else if (userMessage.toLowerCase().contains('power outage')) {
      botResponse = 'During power outages, use flashlights instead of candles, unplug electronics, and keep fridge doors closed.';
    } else if (userMessage.toLowerCase().contains('drought')) {
      botResponse = 'In droughts, conserve water, avoid unnecessary usage, and follow local restrictions on water use.';
    } else if (userMessage.toLowerCase().contains('help')) {
      botResponse = 'If you need emergency assistance, contact your local emergency services or disaster relief organizations.';
    } else {
      botResponse = 'I’m here to help with disaster information. Ask about earthquakes, floods, wildfires, or preparation tips!';
    }

    setState(() {
      _messages.add({'sender': 'Bot', 'text': botResponse});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disaster Chat Bot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUserMessage = message['sender'] == 'User';
                return Container(
                  alignment:
                      isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUserMessage ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      message['text']!,
                      style: TextStyle(
                        color: isUserMessage ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                    ),
                    onSubmitted: (value) {
                      _sendMessage();
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
