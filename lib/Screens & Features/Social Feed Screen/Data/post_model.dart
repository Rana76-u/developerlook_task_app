import 'comment_model.dart';

class Post {
  final String id;
  final String authorName;
  final String authorAvatarUrl;
  final DateTime postDate;
  final num rating;

  final String departureAirport;
  final String arrivalAirport;
  final String airline;
  final String travelClass;
  final String travelDate;

  final String message;

  final List imageUrls;

  final List likes;
  final List<Comment> comments;
  final bool isLiked;

  Post({
    required this.id,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.postDate,
    required this.rating,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.airline,
    required this.travelClass,
    required this.travelDate,
    required this.message,
    required this.imageUrls,
    required this.likes,
    required this.comments,
    required this.isLiked,
  });
}