import 'package:flutter/material.dart';

class CustomImageLayout extends StatelessWidget {
  final List imageUrls;
  final double imageHeight;

  const CustomImageLayout({
    super.key,
    required this.imageUrls,
    this.imageHeight = 200,
  });

  @override
  Widget build(BuildContext context) {
    int count = imageUrls.length;

    if (count == 1) {
      return _buildSingleImage(imageUrls[0]);
    } else if (count == 2) {
      return _buildTwoImages(imageUrls);
    } else if (count == 3) {
      return _buildThreeImages(imageUrls);
    } else {
      return _buildFourOrMore(imageUrls);
    }
  }

  Widget _buildSingleImage(String url) {
    return Image.network(url, height: imageHeight, width: double.infinity, fit: BoxFit.cover);
  }

  Widget _buildTwoImages(List urls) {
    return Row(
      children: urls.map((url) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Image.network(url, height: imageHeight, fit: BoxFit.cover),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildThreeImages(List urls) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Image.network(urls[0], height: imageHeight, fit: BoxFit.cover),
        ),
        SizedBox(width: 2),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Image.network(urls[1], height: imageHeight / 2 - 1, fit: BoxFit.cover),
              SizedBox(height: 2),
              Image.network(urls[2], height: imageHeight / 2 - 1, fit: BoxFit.cover),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFourOrMore(List urls) {
    List displayUrls = urls.take(4).toList();
    int remainingCount = urls.length - 4;

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 1,
      ),
      itemCount: displayUrls.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Image.network(
              displayUrls[index],
              height: imageHeight / 2 - 1,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            if (index == 3 && remainingCount > 0)
              Container(
                color: Colors.black.withValues(alpha: 0.5),
                alignment: Alignment.center,
                child: Text(
                  '+$remainingCount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}


