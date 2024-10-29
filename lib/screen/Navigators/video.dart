import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  VideoPageState createState() => VideoPageState();
}

class VideoPageState extends State<VideoPage> {
  File? _videoFile; // Variable to store the captured video
  final TextEditingController _disasterNameController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  Future<void> _pickVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.camera);

    if (video != null) {
      setState(() {
        _videoFile = File(video.path); // Store the video file
      });
      // Show snackbar only if the widget is still mounted
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Video captured successfully!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disaster Report Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _disasterNameController,
              decoration: const InputDecoration(
                labelText: 'Disaster Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _remarksController,
              decoration: const InputDecoration(
                labelText: 'Remarks',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickVideo,
              child: const Text('Record Video'),
            ),
            if (_videoFile != null) ...[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text('Video path: ${_videoFile!.path}'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement your upload functionality here
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Uploading video...')),
                    );
                  }
                },
                child: const Text('Upload Video'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _disasterNameController.dispose();
    _remarksController.dispose();
    super.dispose();
  }
}
