import '../../domain/model/comment_entity.dart';
import '../../domain/model/like_entity.dart';
import '../../domain/model/post_entity.dart';

//---------post----------
abstract class PostStates {}

class PostStateLoading extends PostStates {}

class PostStateLoaded extends PostStates {
  final List<PostEntity> postList;

  PostStateLoaded({
    required this.postList,
  });
}

class PostStateLazyLoading extends PostStateLoaded {
  PostStateLazyLoading({required super.postList});
}

class PostStateError extends PostStates {
  final String message;

  PostStateError({
    required this.message,
  });
}

//---------likes----------
abstract class LikesState {}

class LikesStateLoading extends LikesState {}

class LikesStateLazyLoading extends LikesStateLoaded {
  LikesStateLazyLoading({required super.likesList});
}

class LikesStateInactive extends LikesState {}

class LikesStateLoaded extends LikesState {
  final List<LikeEntity> likesList;

  LikesStateLoaded({
    required this.likesList,
  });
}

class LikesStateError extends LikesState {
  final String message;

  LikesStateError({
    required this.message,
  });
}

//---------comments----------
abstract class CommentsState {}

class CommentsInactive extends CommentsState {}

class CommentOnPostStateLoading extends CommentsStateLoaded {
  String? postId;

  CommentOnPostStateLoading({
    this.postId,
    required super.commentsList,
  });
}

class CommentsStateLoading extends CommentsState {}

class CommentsStateLoaded extends CommentsState {
  final List<CommentEntity> commentsList;

  CommentsStateLoaded({
    required this.commentsList,
  });
}

class CommentsStateLazyLoading extends CommentsStateLoaded {
  CommentsStateLazyLoading({required super.commentsList});
}

class CommentsStateError extends CommentsState {
  final String message;

  CommentsStateError({
    required this.message,
  });
}
