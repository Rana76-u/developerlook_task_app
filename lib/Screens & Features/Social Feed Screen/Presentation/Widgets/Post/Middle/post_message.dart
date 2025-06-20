import 'package:flutter/material.dart';
import '../../../../Data/post_model.dart';

class PostMessage extends StatelessWidget {
  final Post post;
  const PostMessage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(post.message, style: const TextStyle(fontSize: 14, height: 1.4)),
        const SizedBox(height: 4),
        Text('See More',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}
