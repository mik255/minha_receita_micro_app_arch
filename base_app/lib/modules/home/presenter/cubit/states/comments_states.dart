import '../../../model/comment_entity.dart';
import '../../../model/post_entity.dart';

class CommentStates {}

class PostCommentInitial extends CommentStates {}

class PostCommentLoading extends CommentStates {}

class PostCommentSuccess extends CommentStates {}

class PostCommentError extends CommentStates {}

//-------------

class CommentsLoadStates {}

class CommentsLoadLoading extends CommentsLoadStates {}

class CommentsLoadSuccess extends CommentsLoadStates {
  List<CommentEntity> comments;

  CommentsLoadSuccess({required this.comments});
}

class CommentsLoadError extends CommentsLoadStates {}
