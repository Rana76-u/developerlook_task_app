import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'model.dart';
import 'open.dart';

class MultiImageViewer extends StatelessWidget {
  const MultiImageViewer({
    super.key,
    required this.images,
    this.backgroundColor = Colors.black87,
    this.textStyle = const TextStyle(
      fontSize: 30,
      color: Colors.white,
    ),
    this.height = 205,
    this.width,
    this.networkImageHeaders,
  });

  final Map<String, String>? networkImageHeaders;

  final Color backgroundColor;

  final TextStyle textStyle;

  // List<ImageModel> of images and captions to display.
  // Each image is displayed with respect to its corresponding caption.
  // captions are optional.
  final List<ImageModel> images;

  // Height of the image.
  // defaults 205.
  final double height;

  // Width of the images.
  final double? width;

  CachedNetworkImageProvider _createNetworkImage(String path) =>
      CachedNetworkImageProvider(path, headers: networkImageHeaders);

  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.sizeOf(context).width;
    final imagesList = images.map((image) => image.imageUrl).toList();
    final captionList = images
        .any((image) => image.caption != null && image.caption!.isNotEmpty)
        ? images.map((image) => image.caption ?? '').toList()
        : null;

    switch (images.length) {
      case 0:
        return const SizedBox();

      case 1:
        return GestureDetector(
          onTap: () => openImage(
              context, 0, imagesList, captionList, networkImageHeaders),
          child: Container(
            height: height,
            width: width ?? defaultWidth,
            decoration: BoxDecoration(
              color: backgroundColor,
              image: DecorationImage(
                  image: _createNetworkImage(images.first.imageUrl),
                  fit: BoxFit.cover),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          ),
        );

      case 2:
        return SizedBox(
          height: height,
          width: width ?? defaultWidth,
          child: Row(children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 1),
                child: GestureDetector(
                  onTap: () => openImage(
                      context, 0, imagesList, captionList, networkImageHeaders),
                  child: Container(
                    height: height,
                    width: width == null ? defaultWidth / 2 : width! / 2,
                    decoration: BoxDecoration(
                        color: backgroundColor,
                        image: DecorationImage(
                            image: _createNetworkImage(images.first.imageUrl),
                            fit: BoxFit.cover),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5))),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: GestureDetector(
                  onTap: () => openImage(
                      context, 1, imagesList, captionList, networkImageHeaders),
                  child: Container(
                    height: height,
                    width: width == null ? defaultWidth / 2 : width! / 2,
                    decoration: BoxDecoration(
                        color: backgroundColor,
                        image: DecorationImage(
                            image: _createNetworkImage(images[1].imageUrl),
                            fit: BoxFit.cover),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5))),
                  ),
                ),
              ),
            ),
          ]),
        );

      case 3:
        return SizedBox(
          height: height,
          width: width ?? defaultWidth,
          child: Row(children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2, bottom: 2),
                      child: GestureDetector(
                        onTap: () => openImage(context, 0, imagesList,
                            captionList, networkImageHeaders),
                        child: Container(
                          decoration: BoxDecoration(
                              color: backgroundColor,
                              image: DecorationImage(
                                  image: _createNetworkImage(
                                      images.first.imageUrl),
                                  fit: BoxFit.cover),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5))),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: GestureDetector(
                        onTap: () => openImage(context, 1, imagesList,
                            captionList, networkImageHeaders),
                        child: Container(
                          width: width == null ? defaultWidth / 2 : width! / 2,
                          decoration: BoxDecoration(
                              color: backgroundColor,
                              image: DecorationImage(
                                  image:
                                  _createNetworkImage(images[1].imageUrl),
                                  fit: BoxFit.cover),
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(5))),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: GestureDetector(
                  onTap: () => openImage(
                      context, 2, imagesList, captionList, networkImageHeaders),
                  child: Container(
                    width: width == null ? defaultWidth / 2 : width! / 2,
                    decoration: BoxDecoration(
                        color: backgroundColor,
                        image: DecorationImage(
                            image: _createNetworkImage(images[2].imageUrl),
                            fit: BoxFit.cover),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5))),
                  ),
                ),
              ),
            ),
          ]),
        );

      case 4:
        return SizedBox(
          height: height,
          width: width ?? defaultWidth,
          child: Row(children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2, bottom: 2),
                      child: GestureDetector(
                        onTap: () => openImage(context, 0, imagesList,
                            captionList, networkImageHeaders),
                        child: Container(
                          // width: width == null ? defaultWidth / 2 : width! / 2,
                          decoration: BoxDecoration(
                              color: backgroundColor,
                              image: DecorationImage(
                                  image: _createNetworkImage(
                                      images.first.imageUrl),
                                  fit: BoxFit.cover),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5))),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: GestureDetector(
                        onTap: () => openImage(context, 1, imagesList,
                            captionList, networkImageHeaders),
                        child: Container(
                          width: width == null ? defaultWidth / 2 : width! / 2,
                          decoration: BoxDecoration(
                              color: backgroundColor,
                              image: DecorationImage(
                                  image:
                                  _createNetworkImage(images[1].imageUrl),
                                  fit: BoxFit.cover),
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(5))),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0, bottom: 2),
                      child: GestureDetector(
                        onTap: () => openImage(context, 2, imagesList,
                            captionList, networkImageHeaders),
                        child: Container(
                          width: width == null ? defaultWidth / 2 : width! / 2,
                          decoration: BoxDecoration(
                              color: backgroundColor,
                              image: DecorationImage(
                                  image:
                                  _createNetworkImage(images[2].imageUrl),
                                  fit: BoxFit.cover),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(5))),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0, top: 0),
                      child: GestureDetector(
                        onTap: () => openImage(context, 3, imagesList,
                            captionList, networkImageHeaders),
                        child: Container(
                          width: width == null ? defaultWidth / 2 : width! / 2,
                          decoration: BoxDecoration(
                              color: backgroundColor,
                              image: DecorationImage(
                                  image:
                                  _createNetworkImage(images[3].imageUrl),
                                  fit: BoxFit.cover),
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(5))),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        );

      default:
        return SizedBox(
          height: height,
          width: width ?? defaultWidth,
          child: Row(children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2, bottom: 2),
                      child: GestureDetector(
                        onTap: () => openImage(context, 0, imagesList,
                            captionList, networkImageHeaders),
                        child: Container(
                          decoration: BoxDecoration(
                              color: backgroundColor,
                              image: DecorationImage(
                                  image: _createNetworkImage(
                                      images.first.imageUrl),
                                  fit: BoxFit.cover),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5))),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: GestureDetector(
                        onTap: () => openImage(context, 1, imagesList,
                            captionList, networkImageHeaders),
                        child: Container(
                          width: width == null ? defaultWidth / 2 : width! / 2,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            image: DecorationImage(
                                image: _createNetworkImage(images[1].imageUrl),
                                fit: BoxFit.cover),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0, bottom: 2),
                      child: GestureDetector(
                        onTap: () => openImage(context, 2, imagesList,
                            captionList, networkImageHeaders),
                        child: Container(
                          width: width == null ? defaultWidth / 2 : width! / 2,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            image: DecorationImage(
                                image: _createNetworkImage(images[2].imageUrl),
                                fit: BoxFit.cover),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0, top: 0),
                      child: GestureDetector(
                        onTap: () => openImage(context, 3, imagesList,
                            captionList, networkImageHeaders),
                        child: Container(
                          width: width == null ? defaultWidth / 2 : width! / 2,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            image: DecorationImage(
                                image: _createNetworkImage(images[3].imageUrl),
                                fit: BoxFit.cover),
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5),
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(5),
                              ),
                            ),
                            child: Center(
                                child: Text("+${images.length - 4}",
                                    style: textStyle)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        );
    }
  }
}
