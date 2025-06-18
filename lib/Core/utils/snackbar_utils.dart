// snackbar_utils.dart
import 'package:flutter/material.dart';
import 'package:developerlook_task_app/Core/utils/reservse_progress_bar.dart';

class SnackbarUtils {
  static void showMissingFieldsSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Icons.error, color: Colors.red),
                SizedBox(width: 10),
                Text('Missing Required Fields', style: TextStyle(color: Colors.black)),
              ],
            ),
            SizedBox(height: 20),
            ReverseProgressBar(),
          ],
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.white,
      ),
    );
  }

  static void showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  static void showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}
