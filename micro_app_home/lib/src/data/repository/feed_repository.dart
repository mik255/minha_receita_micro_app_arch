import '../../domain/model/comment_entity.dart';
import '../../domain/model/like_entity.dart';
import '../../domain/model/post_entity.dart';
import '../../domain/repository/post_repository.dart';
import '../datasource/feed_datasource.dart';

class FeedRepositoryImpl implements PostRepository {
  final FeedDataSource _feedDataSource;

  FeedRepositoryImpl({required FeedDataSource feedDataSource})
      : _feedDataSource = feedDataSource;

  @override
  Future<List<PostEntity>> getPostList(int page, int size) async {
    return await _feedDataSource.getListPost(page, size);
  }

  @override
  Future<List<CommentEntity>> getCommentsByPostId(
      String postId, int page, int size) {
    return _feedDataSource.getPostComments(postId, page, size);
  }

  @override
  Future<List<LikeEntity>> getPostLikes(String id, int page, int size) {
    return _feedDataSource.getPostLikes(id, page, size);
  }

  @override
  Future<CommentEntity> createComment(String postId, CommentEntity comment) {
    return _feedDataSource.createComment(postId, comment);
  }

  @override
  createLike(id, LikeEntity like) {
    _feedDataSource.createLike(id, like);
  }

  @override
  removeLike(String id, LikeEntity like) {
    _feedDataSource.removeLike(id, like);
  }
}
