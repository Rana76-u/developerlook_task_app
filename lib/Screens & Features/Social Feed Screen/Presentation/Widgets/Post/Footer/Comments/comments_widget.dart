import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Social%20Feed%20Screen/Data/post_date_formatter.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Social%20Feed%20Screen/Data/user_interaction_services.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Social%20Feed%20Screen/Presentation/Widgets/Post/Footer/Comments/reply_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class CommentsWidget extends StatelessWidget {
  final String postId;
  final List<QueryDocumentSnapshot> comments;
  const CommentsWidget({super.key, required this.postId, required this.comments});

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return const Center(child: Text('No comments yet.'));
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index].data() as Map<String, dynamic>;

        return StreamBuilder(
          stream: FirebaseFirestore
              .instance
              .collection('reviews')
              .doc(postId).collection('Comments')
              .doc(comments[index].id)
              .collection('Upvote')
              .snapshots(),
          builder: (context, upvoteSnapshot) {
            if (upvoteSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            num upVoteCount = 0;
            bool isUpVoted = upvoteSnapshot.data!.docs
                .any((doc) => doc.get('userId') == FirebaseAuth.instance.currentUser!.uid);

            if(upvoteSnapshot.hasData){
              upVoteCount = upvoteSnapshot.data!.docs.length;
            }

            return _commentCard(comment, upVoteCount, isUpVoted, index);
          },
        );
      },
    );
  }
  
  Widget _commentCard(Map<String, dynamic> comment, num upVoteCount, bool isUpVoted, int index) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(comment['userPhotoUrl']),
                radius: 14,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(comment['userName'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13)),
                    Text(PostDateFormatter().formatPostDate(Timestamp.fromMillisecondsSinceEpoch(
                        comment['createdAt'].millisecondsSinceEpoch).toDate()),
                        style: const TextStyle(fontSize: 11)),
                  ],
                ),
              ),
              Text('$upVoteCount Upvote',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500
                  )
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(comment['text'], style: const TextStyle(fontSize: 13)),
          Row(
            children: [
              _upvoteAComment(isUpVoted, index),
              SizedBox(width: 25),
              Expanded(child: _replyAComment(comments[index].id))
            ],
          ),

          const SizedBox(height: 8),
          _repliesContainer(postId, comments[index].id),
        ],
      ),
    );
  }

  Widget _upvoteAComment(bool isUpVoted, int index) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            isUpVoted ? EvaIcons.arrow_circle_up : EvaIcons.arrow_circle_up_outline,
          ),
          onPressed: () {
            UserInteractionServices().upvoteComment(postId, comments[index].id);
          },
        ),
        Text('Upvote')
      ],
    );
  }

  Widget _replyAComment(String commentId) {
    return ReplyInputWidget(postId: postId, commentId: commentId);
  }

  Widget _repliesContainer(String postId, String commentId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('reviews')
          .doc(postId)
          .collection('Comments')
          .doc(commentId)
          .collection('Replies')
          .orderBy('createdAt', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const SizedBox();
        }

        final replies = snapshot.data!.docs;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: replies.length,
          itemBuilder: (context, index) {
            final reply = replies[index].data() as Map<String, dynamic>;

            return Padding(
              padding: const EdgeInsets.only(left: 32.0, top: 8.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(reply['userPhotoUrl']),
                          radius: 12,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(reply['userName'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            Text(PostDateFormatter().formatPostDate(
                                (reply['createdAt'] as Timestamp).toDate()),
                                style: const TextStyle(fontSize: 10)),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(reply['text'], style: const TextStyle(fontSize: 13)),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

}
