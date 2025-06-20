import 'package:developerlook_task_app/Screens%20&%20Features/Social%20Feed%20Screen/Data/user_interaction_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReplyInputWidget extends StatefulWidget {
  final String postId;
  final String commentId;
  const ReplyInputWidget({super.key, required this.postId, required this.commentId});

  @override
  State<ReplyInputWidget> createState() => _ReplyInputWidgetState();
}

class _ReplyInputWidgetState extends State<ReplyInputWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _isSending = false;

  Future<void> _sendComment() async {
    final user = FirebaseAuth.instance.currentUser;
    final text = _controller.text.trim();

    if (user == null || text.isEmpty) return;

    setState(() => _isSending = true);

    UserInteractionServices().makeReply(widget.postId, widget.commentId, text, user);

    _controller.clear();
    setState(() => _isSending = false);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                user?.photoURL ?? 'https://via.placeholder.com/150'),
            radius: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Write reply...',
                hintStyle: const TextStyle(fontSize: 13),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                //filled: true,
                //fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _isSending ? null : _sendComment,
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 18,
              child: _isSending
                  ? const CircularProgressIndicator(
                  color: Colors.white, strokeWidth: 2)
                  : const Icon(Icons.send, color: Colors.white, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}
