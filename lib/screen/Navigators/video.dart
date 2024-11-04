import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  VideoPageState createState() => VideoPageState();
}

class VideoPageState extends State<VideoPage> {
  File? _videoFile;
  final TextEditingController _disasterNameController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  Future<void> _pickVideo() async {
    final XFile? video = await picker.pickVideo(source: ImageSource.camera);
    if (video != null && mounted) {
      setState(() {
        _videoFile = File(video.path);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Video captured successfully!')),
        );
      }
    }
  }

  Future<void> _uploadVideo() async {
    if (_videoFile == null) return;

    // Define storage and collection paths
    final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final Reference storageRef = FirebaseStorage.instance.ref().child('videos/$fileName');
    final UploadTask uploadTask = storageRef.putFile(_videoFile!);

    await uploadTask;
    final String videoURL = await storageRef.getDownloadURL();

    if (mounted) {
      // Store video metadata in Firestore
      await FirebaseFirestore.instance.collection('videos').add({
        'disasterName': _disasterNameController.text,
        'remarks': _remarksController.text,
        'videoURL': videoURL,
        'timestamp': DateTime.now(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Video uploaded successfully!')),
        );
      }

      setState(() {
        _videoFile = null; // Clear the file after uploading
      });
    }
  }

  Widget _buildVideoList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('videos').orderBy('timestamp', descending: true).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final doc = snapshot.data!.docs[index];
            final videoURL = doc['videoURL'];
            final disasterName = doc['disasterName'];
            final remarks = doc['remarks'];
            return ListTile(
              title: Text(disasterName),
              subtitle: Text(remarks),
              onTap: () {
                if (mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VideoPlayerScreen(videoURL: videoURL)),
                  );
                }
              },
            );
          },
        );
      },
    );
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
                onPressed: _uploadVideo,
                child: const Text('Upload Video'),
              ),
            ],
            const SizedBox(height: 16),
            Expanded(child: _buildVideoList()), // Display uploaded videos
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

class VideoPlayerScreen extends StatefulWidget {
  final String videoURL;
  const VideoPlayerScreen({super.key, required this.videoURL});

  @override
  VideoPlayerScreenState createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoURL))
      ..initialize().then((_) {
        if (mounted) {
          setState(() {}); // Refresh to show the video
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Watch Video')),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying ? _controller.pause() : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
