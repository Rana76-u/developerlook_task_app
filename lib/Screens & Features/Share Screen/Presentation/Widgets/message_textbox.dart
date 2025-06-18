import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Bloc/share_review_event.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Bloc/share_review_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc/share_review_state.dart';

class MessageTextbox extends StatefulWidget {
  const MessageTextbox({super.key});

  @override
  State<MessageTextbox> createState() => _MessageTextboxState();
}

class _MessageTextboxState extends State<MessageTextbox> {
  late final TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShareReviewBloc, ShareReviewState>(
      builder: (context, state) {
        if (_messageController.text != state.message) {
          _messageController.text = state.message;
          _messageController.selection = TextSelection.fromPosition(
            TextPosition(offset: _messageController.text.length),
          );
        }
        return TextField(
          controller: _messageController,
          maxLines: 6,
          onChanged: (value) {
            context.read<ShareReviewBloc>().add(UpdateMessage(value));
          },
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            hintText: 'Write your message',
            hintStyle: const TextStyle(
              color: Color(0xFFB0B0B0),
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
          ),
        );
      },
    );
  }
}
