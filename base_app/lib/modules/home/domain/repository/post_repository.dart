import '../model/comment_entity.dart';
import '../model/like_entity.dart';
import '../model/post_entity.dart';

abstract class PostRepository {
  Future<List<PostEntity>> getPostList(int page, int size);

  Future<List<CommentEntity>> getCommentsByPostId(
      String postId, int page, int size);

  Future<List<LikeEntity>> getPostLikes(String postId, int page, int size);

  Future<CommentEntity> createComment(String postId, CommentEntity comment);

  createLike(id, LikeEntity like);

  removeLike(String id, LikeEntity like);
}
