import 'package:developerlook_task_app/Screens%20&%20Features/Social%20Feed%20Screen/Data/post_date_formatter.dart';
import 'package:flutter/material.dart';
import '../../../../Data/post_model.dart';

class PostHeader extends StatelessWidget {
  final Post post;
  const PostHeader({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display the author's avatar
        CircleAvatar(
          backgroundImage: NetworkImage(post.authorAvatarUrl),
          radius: 20,
        ),
        const SizedBox(width: 10),

        // Display the author's name and post date
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.authorName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
              Text(PostDateFormatter().formatPostDate(post.postDate), style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),

        // Display the post rating as stars
        Row(
          children: [
            Row(
              children: List.generate(
                5,
                    (index) => Icon(
                  index < post.rating
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.amber,
                  size: 18,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Text(post.rating.toDouble().toString(),
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
