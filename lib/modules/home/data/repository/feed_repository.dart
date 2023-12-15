import 'package:minha_receita/modules/home/domain/model/comment_entity.dart';
import 'package:minha_receita/modules/home/domain/model/post_entity.dart';
import 'package:minha_receita/modules/home/domain/model/like_entity.dart';
import 'package:minha_receita/modules/home/domain/repository/post_repository.dart';

import '../datasource/feed_datasource.dart';

class FeedRepositoryImpl implements PostRepository {
  final PostDataSource _feedDataSource;

  FeedRepositoryImpl({required PostDataSource feedDataSource})
      : _feedDataSource = feedDataSource;

  @override
  Future<List<PostEntity>> getPostList(int page,int size) async {
    return await _feedDataSource.getListPost(page,size);
  }

  @override
  Future<List<CommentEntity>> getPostCommentsByPostId(String id,int count) {
    return _feedDataSource.getPostComments(id,count);
  }

  @override
  Future<List<LikeEntity>> getPostLikes(String id,int count) {
    return _feedDataSource.getPostLikes(id,count);
  }
}
