import '../../../../domain/model/comment_entity.dart';
import '../../../../domain/model/post_entity.dart';

sealed class CommentsState {}

class CommentLoadingState extends CommentsState {}

class CommentSuccessState extends CommentsState {
  List<CommentEntity> listComments;

  CommentSuccessState(this.listComments);
}

class CommentFailureState extends CommentsState {
  final String message;

  CommentFailureState(this.message);
}
