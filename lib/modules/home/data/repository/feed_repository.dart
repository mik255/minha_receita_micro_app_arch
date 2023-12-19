import 'package:minha_receita/modules/home/domain/model/comment_entity.dart';
import 'package:minha_receita/modules/home/domain/model/post_entity.dart';
import 'package:minha_receita/modules/home/domain/model/like_entity.dart';
import 'package:minha_receita/modules/home/domain/repository/post_repository.dart';

import '../datasource/feed_datasource.dart';

class FeedRepositoryImpl implements HomeFeedRepository {
  final FeedDataSource _feedDataSource;

  FeedRepositoryImpl({required FeedDataSource feedDataSource})
      : _feedDataSource = feedDataSource;

  @override
  Future<List<PostEntity>> getPostList(int page,int size) async {
    return await _feedDataSource.getListPost(page,size);
  }

  @override
  Future<List<CommentEntity>> getPostCommentsByPostId(String postId, int page,int size) {
    return _feedDataSource.getPostComments(postId,page,size);
  }

  @override
  Future<List<LikeEntity>> getPostLikes(String id,int count) {
    return _feedDataSource.getPostLikes(id,count);
  }

  @override
  Future<CommentEntity> createComment(String postId, String comment) {
    return _feedDataSource.createComment(postId,comment);
  }
}
