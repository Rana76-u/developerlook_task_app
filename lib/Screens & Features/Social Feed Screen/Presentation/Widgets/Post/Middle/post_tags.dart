import 'package:flutter/material.dart';
import '../../../../Data/post_model.dart';

class PostTags extends StatelessWidget {
  final Post post;
  const PostTags({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final tags = [
      post.departureAirport,
      post.arrivalAirport,
      post.airline,
      post.travelClass,
      post.travelDate
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: tags
          .map((tag) =>
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
                tag,
                style: const TextStyle(
                    fontSize: 12,
                  fontWeight: FontWeight.bold
                )
            ),
      ))
          .toList(),
    );
  }
}
