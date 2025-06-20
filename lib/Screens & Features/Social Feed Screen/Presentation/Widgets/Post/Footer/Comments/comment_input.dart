import 'package:developerlook_task_app/Screens%20&%20Features/Social%20Feed%20Screen/Data/user_interaction_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CommentInputWidget extends StatefulWidget {
  final String postId;

  const CommentInputWidget({super.key, required this.postId});

  @override
  State<CommentInputWidget> createState() => _CommentInputWidgetState();
}

class _CommentInputWidgetState extends State<CommentInputWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _isSending = false;

  Future<void> _sendComment() async {
    final user = FirebaseAuth.instance.currentUser;
    final text = _controller.text.trim();

    if (user == null || text.isEmpty) return;

    setState(() => _isSending = true);

    UserInteractionServices().makeComment(widget.postId, text, user);

    _controller.clear();
    setState(() => _isSending = false);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Row(
      children: [
        // Display user's profile picture or a placeholder if not available
        CircleAvatar(
          backgroundImage: NetworkImage(
              user?.photoURL ?? 'https://via.placeholder.com/150'),
          radius: 18,
        ),

        // TextField for comment input
        const SizedBox(width: 8),
        _commentInputTextBox(),

        // Send button
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
    );
  }

  Widget _commentInputTextBox() {
    return Expanded(
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Write Your Comment',
          hintStyle: const TextStyle(fontSize: 13),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
