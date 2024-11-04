import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddVideoScreen extends StatefulWidget {
  const AddVideoScreen({super.key});

  @override
  AddVideoScreenState createState() => AddVideoScreenState();
}

class AddVideoScreenState extends State<AddVideoScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _videoFile;
  double _uploadProgress = 0.0;
  bool _isUploading = false;

  final picker = ImagePicker();

  Future<void> _recordVideo() async {
    final pickedFile = await picker.pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(minutes: 2),
    );
    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadVideo() async {
    if (_videoFile == null) return;

    setState(() {
      _isUploading = true;
      _uploadProgress = 0.0;
    });

    // Get a unique file name
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageRef =
        FirebaseStorage.instance.ref().child("videos/$fileName");

    // Start the upload and listen to progress
    UploadTask uploadTask = storageRef.putFile(_videoFile!);

    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      setState(() {
        _uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
      });
    });

    // Wait for the upload to complete
    TaskSnapshot completedSnapshot = await uploadTask;

    // Get the download URL after the upload completes
    String downloadURL = await completedSnapshot.ref.getDownloadURL();

    // Save details to Firestore
    await FirebaseFirestore.instance.collection('videos').add({
      'video_title': _titleController.text,
      'video_description': _descriptionController.text,
      'url': downloadURL,
      'timestamp': FieldValue.serverTimestamp(),
    });

    setState(() {
      _isUploading = false;
      _uploadProgress = 0.0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Video Uploaded Successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Video')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            _videoFile == null
                ? const Text('No video recorded')
                : Text('Video recorded: ${_videoFile!.path}'),
            ElevatedButton(
              onPressed: _recordVideo,
              child: const Text('Record Video'),
            ),
            const SizedBox(height: 20),
            _isUploading
                ? Column(
                    children: [
                      LinearProgressIndicator(value: _uploadProgress),
                      const SizedBox(height: 10),
                      Text(
                          '${(_uploadProgress * 100).toStringAsFixed(0)}% uploaded'),
                    ],
                  )
                : ElevatedButton(
                    onPressed: _uploadVideo,
                    child: const Text('Upload Video'),
                  ),
          ],
        ),
      ),
    );
  }
}
