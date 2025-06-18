import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class DottedBorderBox extends StatelessWidget {
  const DottedBorderBox({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: const Color(0x4D384EB7),
      borderType: BorderType.RRect,
      radius: const Radius.circular(8),
      dashPattern: const [6, 3],
      child: Container(
        width: 65,
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8FF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Icon(Icons.add, size: 30, color: Colors.grey),
        ),
      ),
    );
  }
}