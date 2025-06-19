import 'package:developerlook_task_app/Screens%20&%20Features/Social%20Feed%20Screen/Data/post_model.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 10),
            _buildTags(),
            const SizedBox(height: 10),
            Text(post.message,
                style: const TextStyle(fontSize: 14, height: 1.4)),
            const SizedBox(height: 4),
            Text('See More',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                  post.imageUrls.isNotEmpty && post.imageUrls[0].isNotEmpty
                      ? post.imageUrls[0]
                      : 'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover),
            ),
            const SizedBox(height: 10),
            //Text('${post.likes.length} Like • ${post.comments.length} Comment'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.thumb_up_alt_outlined),
                Icon(Icons.share_outlined),
              ],
            ),
            const Divider(height: 24),
            //_buildComment(),
            const SizedBox(height: 10),
            Text('See More Comments',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueGrey[800],
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            //_buildCommentInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(post.authorAvatarUrl),
          radius: 20,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.authorName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
              Text(post.postDate.toString(), style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
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
            Text(post.rating.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildTags() {

    final tags = [
      post.departureAirport,
      post.arrivalAirport,
      post.airline,
      post.travelClass,
      post.travelDate
    ];

    return Wrap(
      spacing: 8,
      children: tags
          .map((tag) => Chip(
        label: Text(tag,
            style: const TextStyle(fontSize: 12)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
      ))
          .toList(),
    );
  }

  Widget _buildComment() {

    if (post.comments.isEmpty) {
      return const SizedBox.shrink(); // No comments to display
    }
    else{
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(post.comments[0].commenterAvatarUrl),
                  radius: 14,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.comments[0].commenterName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13)),
                      Text(post.comments[0].timeAgo,
                          style: const TextStyle(fontSize: 11)),
                    ],
                  ),
                ),
                Text('${post.comments[0].upVotes} Upvotes',
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),
            Text(post.comments[0].text, style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.arrow_upward, size: 18),
                SizedBox(width: 16),
                Icon(Icons.reply, size: 18),
              ],
            )
          ],
        ),
      );
    }

  }

  Widget _buildCommentInput() {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(post.comments[0].commenterAvatarUrl),
          radius: 16,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Write Your Comment',
              hintStyle: const TextStyle(fontSize: 13),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 10),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        CircleAvatar(
          backgroundColor: Colors.black,
          radius: 18,
          child: const Icon(Icons.send, color: Colors.white, size: 16),
        ),
      ],
    );
  }
}
