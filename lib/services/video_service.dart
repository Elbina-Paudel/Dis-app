// services/video_service.dart
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Uploads the video to Firebase Storage and saves metadata to Firestore
  Future<void> uploadVideo(
      File videoFile, String disasterName, String remarks) async {
    try {
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final Reference storageRef = _storage.ref().child('videos/$fileName');
      final UploadTask uploadTask = storageRef.putFile(videoFile);

      await uploadTask;
      final String videoURL = await storageRef.getDownloadURL();

      // Store video metadata in Firestore
      await _firestore.collection('videos').add({
        'disasterName': disasterName,
        'remarks': remarks,
        'videoURL': videoURL,
        'timestamp': DateTime.now(),
      });
    } catch (e) {
      throw Exception('Error uploading video: $e');
    }
  }

  // Fetches a stream of videos ordered by timestamp
  Stream<QuerySnapshot> fetchVideos() {
    return _firestore
        .collection('videos')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
