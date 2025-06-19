import 'package:developerlook_task_app/Screens%20&%20Features/Social%20Feed%20Screen/Data/post_model.dart';
import 'package:equatable/equatable.dart';

class SocialFeedState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final List<Post> posts;

  const SocialFeedState({
    this.isLoading = false,
    this.errorMessage,
    this.posts = const [],
  });

  SocialFeedState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<Post>? posts,
  }) {
    return SocialFeedState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      posts: posts ?? this.posts,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, posts];
}