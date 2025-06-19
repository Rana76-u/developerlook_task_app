import 'package:developerlook_task_app/Core/Buttons/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TopRowButtons extends StatelessWidget {
  const TopRowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        CustomIconButton(
          label: 'Share your experience',
          icon: Icons.group_outlined,
          onPressed: () {
            GoRouter.of(context).push('/sharescreen');
          },
        ),
        CustomIconButton(
          label: 'Ask a question',
          icon: Icons.help_outline,
          onPressed: () {},
        ),
        CustomIconButton(
          label: 'Search',
          icon: Icons.search,
          onPressed: () {},
        ),
      ],
    );
  }
}
