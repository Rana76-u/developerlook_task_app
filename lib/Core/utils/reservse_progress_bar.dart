import 'package:flutter/material.dart';

class ReverseProgressBar extends StatefulWidget {
  const ReverseProgressBar({super.key});

  @override
  State<ReverseProgressBar> createState() => _ReverseProgressBarState();
}

class _ReverseProgressBarState extends State<ReverseProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _progressAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {}); // Triggers rebuild to update the progress
      });

    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: _progressAnimation.value,
      backgroundColor: const Color(0xFFFFCDD2),
      valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
    );
  }
}
