import '../../../../domain/model/post_entity.dart';

sealed class LikesState {}

class FeedLikesLoadingState extends LikesState {}

class FeedLikesSuccessState extends LikesState {
  final PostEntity feedEntityWithLikes;

  FeedLikesSuccessState(this.feedEntityWithLikes);
}

class FeedLikesFailureState extends LikesState {
  final String message;

  FeedLikesFailureState(this.message);
}
