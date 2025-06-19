class Comment {
  final String commenterName;
  final String commenterAvatarUrl;
  final String timeAgo;
  final int upVotes;
  final String text;

  Comment({
    required this.commenterName,
    required this.commenterAvatarUrl,
    required this.timeAgo,
    required this.upVotes,
    required this.text,
  });
}