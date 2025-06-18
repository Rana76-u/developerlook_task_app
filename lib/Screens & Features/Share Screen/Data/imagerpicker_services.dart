import 'dart:io';
import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Bloc/share_review_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/share_review_event.dart';

class ImagePickerServices {
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImages(BuildContext context) async {
    final bloc = context.read<ShareReviewBloc>();

    final List<XFile> pickedFiles = await _picker.pickMultiImage();
    final existingImages = List<File>.from(bloc.state.pickedImages);
    final updatedImagesList = [...existingImages, ...pickedFiles.map((x) => File(x.path))];

    if (updatedImagesList.isNotEmpty) {
      bloc.add(UpdatePickedImagesList(updatedImagesList));
      bloc.add(ToggleRedBorder(false));
    }
  }

  void removeImage(BuildContext context, int imageIndex) {
    final bloc = context.read<ShareReviewBloc>();
    final updatedImages = List<File>.from(bloc.state.pickedImages);
    updatedImages.removeAt(imageIndex);
    BlocProvider.of<ShareReviewBloc>(context).add(UpdatePickedImagesList(updatedImages));
    //bloc.add(UpdatePickedImagesList(updatedImages));
  }

  bool isPickedImagesEmpty(BuildContext context) {
    return context.read<ShareReviewBloc>().state.pickedImages.isEmpty;
  }
}
