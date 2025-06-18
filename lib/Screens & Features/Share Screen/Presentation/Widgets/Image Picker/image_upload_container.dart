import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Bloc/share_review_state.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ImageUploaderContainer extends StatelessWidget {
  final ShareReviewState state;
  const ImageUploaderContainer({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: state.showRedBorder ? Colors.red : const Color(0x4D384EB7),
      borderType: BorderType.RRect,
      radius: const Radius.circular(14),
      dashPattern: const [8, 4],
      child: Container(
        width: double.infinity,
        height: 160,
        color: const Color(0xFFF8F8FF),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/upload_logo.png', width: 50, height: 50),
              const SizedBox(height: 10),
              RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(text: 'Drop Your Image Here Or ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: 'Browse',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}