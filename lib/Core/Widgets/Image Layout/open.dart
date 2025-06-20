import 'package:flutter/material.dart';


void openImage(BuildContext context, final int index, List<String> unitImages,
    List<String>? captions, Map<String, String>? headers) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Center(
          child: InteractiveViewer(
            child: Image.network(
              unitImages[index],
              headers: headers,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.broken_image, color: Colors.white, size: 48),
              ),
            ),
          ),
        ),
        bottomNavigationBar: captions != null && captions.length > index
            ? Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            captions[index],
            style: const TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        )
            : null,
      ),
    ),
  );
}

