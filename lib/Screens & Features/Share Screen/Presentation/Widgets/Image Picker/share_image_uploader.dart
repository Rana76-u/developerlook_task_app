import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Data/imagerpicker_services.dart';
import 'package:flutter/material.dart';
import '../../../Bloc/share_review_state.dart';
import 'image_upload_container.dart';
import 'picked_image_container.dart';

class ShareImageUploader extends StatelessWidget {
  final ShareReviewState state;
  const ShareImageUploader({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImagePickerServices().isPickedImagesEmpty(context)
            ? GestureDetector(
          onTap: () {
            ImagePickerServices().pickImages(context);
          },
          child: ImageUploaderContainer(state: state,),
        )
            :
        PickedImagesContainer(state: state)
      ],
    );
  }
}



