import 'package:flutter/material.dart';

class PromoBanner extends StatelessWidget {
  final String imageUrl;

  const PromoBanner({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        imageUrl,
        height: 120,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
