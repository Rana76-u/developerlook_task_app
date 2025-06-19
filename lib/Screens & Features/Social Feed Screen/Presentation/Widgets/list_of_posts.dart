import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Social%20Feed%20Screen/Presentation/Widgets/post_card.dart';
import 'package:flutter/material.dart';

import '../../Data/post_model.dart';

class ListOfPosts extends StatelessWidget {
  const ListOfPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('reviews')
            .orderBy('timestamp', descending: true)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LinearProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No posts available.'));
          } else {
            final posts = snapshot.data!.docs;
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final postData = posts[index].data();

                final post = Post(
                  id: posts[index].id,
                  authorName: postData['userName'] ?? '',
                  authorAvatarUrl: postData['userPhotoUrl'] ?? '',
                  postDate: (postData['timestamp'] as Timestamp).toDate(),
                  rating: (postData['rating'])?.toInt() ?? 0,
                  departureAirport: postData['departure']?['code'] ?? '',
                  arrivalAirport: postData['arrival']?['code'] ?? '',
                  airline: postData['airline']?['name'] ?? '',
                  travelClass: postData['class']?['name'] ?? '',
                  travelDate: postData['selectedDate'] != null
                      ? DateTime.tryParse(postData['selectedDate'])?.toIso8601String() ?? ''
                      : '',
                  message: postData['message'] ?? '',
                  imageUrls: (postData['imageUrls'] as List<dynamic>?)
                          ?.map((e) => e.toString())
                          .toList() ??
                      [],
                  likes: [],
                  comments: [],
                  isLiked: false, // Set based on your logic
                );

                return PostCard(post: post);
              },
            );
          }
        },
    );
  }
}
