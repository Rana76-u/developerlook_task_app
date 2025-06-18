import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Bloc/share_review_state.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Data/imagerpicker_services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'dotted_border_box.dart';

class PickedImagesContainer extends StatelessWidget {
  final ShareReviewState state;
  const PickedImagesContainer({super.key, required this.state});

  @override
  Widget build(BuildContext context) {

    return DottedBorder(
      color: state.showRedBorder ? Colors.red : const Color(0x4D384EB7),
      borderType: BorderType.RRect,
      radius: const Radius.circular(14),
      dashPattern: const [8, 4],
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xFFF8F8FF),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ...List.generate(state.pickedImages.length, (imgIndex) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: state.pickedImages.isEmpty ? Colors.red : const Color(0x4D384EB7),
                        width: 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        state.pickedImages[imgIndex],
                        width: 65,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -8,
                    right: -8,
                    child: IconButton(
                      icon: const Icon(Icons.close_rounded, color: Colors.grey, size: 20),
                      onPressed: () {
                        ImagePickerServices().removeImage(context, imgIndex);
                      },
                    ),
                  ),
                ],
              );
            }),
            GestureDetector(
              onTap: () {
                ImagePickerServices().pickImages(context);
              },
              child: DottedBorderBox(),
            ),
          ],
        ),
      ),
    );
  }
}