// review_submission_service.dart
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:developerlook_task_app/Screens & Features/Share Screen/Bloc/share_review_state.dart';

class ReviewSubmissionService {
  static bool hasMissingRequiredFields(ShareReviewState state) {
    return state.pickedImages.isEmpty ||
        state.message.trim().isEmpty ||
        !state.selectedItems.containsKey('departure') ||
        !state.selectedItems.containsKey('arrival') ||
        !state.selectedItems.containsKey('airline') ||
        !state.selectedItems.containsKey('class') ||
        state.selectedDate == null;
  }

  static Future<void> uploadReview(ShareReviewState state) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final List<File> images = state.pickedImages;
    final List<String> imageUrls = [];

    for (int i = 0; i < images.length; i++) {
      final fileName = 'review_images/${DateTime.now().millisecondsSinceEpoch}_$i.jpg';
      final snapshot = await storage.ref(fileName).putFile(images[i]);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrls.add(downloadUrl);
    }

    await firestore.collection('reviews').add({
      'message': state.message,
      'rating': state.rating,
      'departure': state.selectedItems['departure'],
      'arrival': state.selectedItems['arrival'],
      'airline': state.selectedItems['airline'],
      'class': state.selectedItems['class'],
      'selectedDate': state.selectedDate?.toIso8601String(),
      'timestamp': Timestamp.now(),
      'imageUrls': imageUrls,
      'userId': FirebaseAuth.instance.currentUser?.uid,
      'userName': FirebaseAuth.instance.currentUser?.displayName ?? 'Anonymous',
      'userPhotoUrl': FirebaseAuth.instance.currentUser?.photoURL ?? '',
    });
  }
}
