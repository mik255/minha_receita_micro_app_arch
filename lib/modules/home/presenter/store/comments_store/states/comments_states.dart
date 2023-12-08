import '../../../../domain/model/post_entity.dart';

sealed class CommentsState {}

class CommentLoadingState extends CommentsState {}

class CommentSuccessState extends CommentsState {
  PostEntity feedEntityList;

  CommentSuccessState(this.feedEntityList);
}

class CommentFailureState extends CommentsState {
  final String message;

  CommentFailureState(this.message);
}
