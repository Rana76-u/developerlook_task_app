import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserInteractionServices {

  void handleLike(String postId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid; // Replace this with your logic to get the current user ID
    final likeDoc = FirebaseFirestore.instance
        .collection('reviews')
        .doc(postId)
        .collection('Likes')
        .doc(userId);

    final docSnapshot = await likeDoc.get();

    if (docSnapshot.exists) {
      await likeDoc.delete();
    } else {
      await likeDoc.set({
        'likedAt': FieldValue.serverTimestamp(),
        'userId': userId,
      });
    }
  }

  void makeComment(String postId, String text, User user) async {
    final commentData = {
      'userId': user.uid,
      'userName': user.displayName ?? 'Anonymous',
      'userPhotoUrl': user.photoURL ?? '',
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
    };

    await FirebaseFirestore.instance
        .collection('reviews')
        .doc(postId)
        .collection('Comments')
        .add(commentData);
  }

  void upvoteComment(String postId, String commentId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final upvoteDoc = FirebaseFirestore.instance
        .collection('reviews')
        .doc(postId)
        .collection('Comments')
        .doc(commentId)
        .collection('Upvote')
        .doc(userId);

    final docSnapshot = await upvoteDoc.get();

    if (docSnapshot.exists) {
      await upvoteDoc.delete();
    } else {
      await upvoteDoc.set({
        'upvotedAt': FieldValue.serverTimestamp(),
        'userId': userId,
      });
    }
  }

  void makeReply(String postId, String commentId, String text, User user) async {
    final replyData = {
      'userId': user.uid,
      'userName': user.displayName ?? 'Anonymous',
      'userPhotoUrl': user.photoURL ?? '',
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
    };

    await FirebaseFirestore.instance
        .collection('reviews')
        .doc(postId)
        .collection('Comments')
        .doc(commentId)
        .collection('Replies')
        .add(replyData);
  }

}