import 'package:developerlook_task_app/Core/app_export.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Bloc/share_review_state.dart';
import 'package:flutter/material.dart';

import '../../Bloc/share_review_bloc.dart';
import '../../Bloc/share_review_event.dart';

class Rating extends StatelessWidget {
  final ShareReviewState state;
  const Rating({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Rating',
          style: TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            return GestureDetector(
              child: Icon(
                index < state.rating ? Icons.star_rounded : Icons.star_border_rounded,
                color: Colors.amberAccent,
              ),
              onTap: () {
                BlocProvider.of<ShareReviewBloc>(context).add(
                  UpdateRating(index + 1.0),
                );
              },
            );
          }),
        )
      ],
    );
  }
}

