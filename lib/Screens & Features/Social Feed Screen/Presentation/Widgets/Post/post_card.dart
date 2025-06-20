import 'package:developerlook_task_app/Screens%20&%20Features/Social%20Feed%20Screen/Data/post_model.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Social%20Feed%20Screen/Presentation/Widgets/Post/Footer/post_footer.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Social%20Feed%20Screen/Presentation/Widgets/Post/Middle/post_images.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Social%20Feed%20Screen/Presentation/Widgets/Post/Middle/post_message.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Social%20Feed%20Screen/Presentation/Widgets/Post/Middle/post_tags.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Social%20Feed%20Screen/Presentation/Widgets/Post/Header/post_header.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostHeader(post: post),
            const SizedBox(height: 10),
            PostTags(post: post),
            const SizedBox(height: 15),
            PostMessage(post: post),
            const SizedBox(height: 10),
            PostImages(post: post),
            const SizedBox(height: 10),
            PostFooter(postId: post.id),
          ],
        ),
      ),
    );
  }
}
