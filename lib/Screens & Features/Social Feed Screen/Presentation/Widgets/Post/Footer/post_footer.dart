import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Social%20Feed%20Screen/Data/user_interaction_services.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Social%20Feed%20Screen/Presentation/Widgets/Post/Footer/Comments/comment_input.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Social%20Feed%20Screen/Presentation/Widgets/Post/Footer/Comments/comments_widget.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Social%20Feed%20Screen/Presentation/Widgets/Post/Footer/share_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class PostFooter extends StatelessWidget {
  final String postId;

  const PostFooter({required this.postId, super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>( // Listening to the post document
      stream: FirebaseFirestore.instance.collection('reviews').doc(postId).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final postData = snapshot.data!;

        final likesCollection = postData.reference.collection('Likes');
        final commentsCollection = postData.reference.collection('Comments');

        return StreamBuilder<QuerySnapshot>( // Listening to the comments collection
          stream: commentsCollection.snapshots(),
          builder: (context, commentSnap) {
            return StreamBuilder<QuerySnapshot>( // Listening to the likes collection
              stream: likesCollection.snapshots(),
              builder: (context, likeSnap) {
                final likesCount = likeSnap.hasData ? likeSnap.data!.docs.length : 0;
                final comments = commentSnap.hasData ? commentSnap.data!.docs : [];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // Displaying the number of likes and comments
                    Text('$likesCount Likes  •  ${comments.length} Comments'),
                    const SizedBox(height: 15),

                    // Like & Share Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            UserInteractionServices().handleLike(postId);
                          },
                          child: StreamBuilder(
                              stream: likesCollection.doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                              builder: (context, likeSnapshot) {
                                final isLiked = likeSnapshot.hasData && likeSnapshot.data!.exists;
                                return Row(
                                  children: [
                                    Icon(isLiked ? FontAwesome.thumbs_up_solid : FontAwesome.thumbs_up,),
                                    SizedBox(width: 8),
                                    Text('Like', style: TextStyle(fontSize: 14)),
                                  ],
                                );
                              },
                          ),
                        ),
                        ShareButton(contentToShare: 'https://businessclassprofile.com/single-feed?postId=684e174107a87fb45ddc4a48&postType=share')
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Comments Section
                    if (comments.isNotEmpty) CommentsWidget(postId: postId,comments: List<QueryDocumentSnapshot<Object?>>.from(comments)),
                    const SizedBox(height: 10),

                    // See More Comments
                    Text('See More Comments',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),

                    // Comment Input Widget
                    CommentInputWidget(postId: postId),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

}
