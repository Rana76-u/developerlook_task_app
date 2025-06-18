import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Data/review_submission_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:developerlook_task_app/Screens & Features/Share Screen/Bloc/share_review_bloc.dart';
import 'package:developerlook_task_app/Screens & Features/Share Screen/Bloc/share_review_event.dart';
import 'package:developerlook_task_app/Screens & Features/Share Screen/Data/imagerpicker_services.dart';

import '../../../../Core/utils/snackbar_utils.dart';

class ShareSubmissionHandler {

  Future<void> handleSubmit(BuildContext context) async {
    final shareBloc = BlocProvider.of<ShareReviewBloc>(context);
    final navigator = Navigator.of(context);
    final state = context.read<ShareReviewBloc>().state;

    final bool hasMissingFields = ReviewSubmissionService.hasMissingRequiredFields(state);

    if (hasMissingFields) {
      if (ImagePickerServices().isPickedImagesEmpty(context)) {
        shareBloc.add(ToggleRedBorder(true));
      }
      SnackbarUtils.showMissingFieldsSnackbar(context);
      return;
    }

    try {
      shareBloc.add(UpdateIsLoading(true));

      await ReviewSubmissionService.uploadReview(state);

      shareBloc.add(UpdateIsLoading(false));

      if (context.mounted) {
        SnackbarUtils.showSuccessSnackbar(context, 'Review submitted successfully!');
      }

      // Reset form
      shareBloc.add(const UpdateMessage(''));
      shareBloc.add(const UpdatePickedImagesList([]));
      shareBloc.add(const UpdateDropdownSelectedItem(dropdownType: '', selectedItem: {}));
      shareBloc.add(UpdateSelectedDate(DateTime.now()));

      navigator.pop();
    } catch (e) {
      if (context.mounted) {
        SnackbarUtils.showErrorSnackbar(context, 'Failed to submit: $e');
      }
    }
  }
}