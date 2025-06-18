import 'package:developerlook_task_app/Core/app_export.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Bloc/share_review_bloc.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Bloc/share_review_event.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Bloc/share_review_state.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Presentation/Widgets/Date%20Picker/yearmonth_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TravelDatePicker extends StatelessWidget {
  final ShareReviewState state;
  const TravelDatePicker({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ShareReviewBloc>(context);
    return GestureDetector(
      onTap: () async {
        final result = await showDialog(
          context: context,
          builder: (_) => YearMonthPickerDialog(),
        );

        if (result != null && result is DateTime) {
          bloc.add(UpdateSelectedDate(result));
        }
      },
      child: Container(
        width: 140,
        padding: const EdgeInsets.only(left: 15, right: 3, top: 3, bottom: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
          border: Border.all(
            color: Color(0xFFE8E8EA),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              state.selectedDate == null
                  ? "Travel Date"
                  : DateFormat('MM/yyyy').format(state.selectedDate!),
              style: TextStyle(
                fontSize: state.selectedDate == null ? 13 : 14.5,
                color: state.selectedDate == null ? Colors.grey : Colors.black,
                fontWeight: state.selectedDate == null ? FontWeight.normal : FontWeight.bold,
              ),
            ),
            SizedBox(width: 10),
            Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Color(0xFFE4E4E4),
              ),
              child: Image.asset(
                'assets/images/calendar.png',
                width: 20,
                height: 20,
                fit: BoxFit.cover,
                color: Colors.white,
                colorBlendMode: BlendMode.modulate,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

