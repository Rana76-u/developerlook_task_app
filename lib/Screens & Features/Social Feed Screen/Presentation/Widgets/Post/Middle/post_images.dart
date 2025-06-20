import 'package:flutter/material.dart';
import '../../../../../../Core/Widgets/Image Layout/model.dart';
import '../../../../../../Core/Widgets/Image Layout/viewer.dart';
import '../../../../Data/post_model.dart';

class PostImages extends StatelessWidget {
  final Post post;
  const PostImages({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final List<String> urls = post.imageUrls.where((url) => url.isNotEmpty).toList().cast<String>();

    if (urls.isEmpty) {
      return Image.network(
        'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      );
    }

    return MultiImageViewer(
      images: urls.map((url) => ImageModel(imageUrl: url)).toList(),
      height: 200,
      width: double.infinity,
      backgroundColor: Colors.primaries[urls.length % Colors.primaries.length].withValues(alpha: 0.3),
    );
  }
}