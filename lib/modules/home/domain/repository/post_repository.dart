import 'package:minha_receita/modules/home/domain/model/post_entity.dart';
import 'package:minha_receita/modules/home/domain/model/like_entity.dart';

import '../model/comment_entity.dart';

abstract class HomeFeedRepository {
  Future<List<PostEntity>> getPostList(int page,int size);

  Future<List<CommentEntity>> getPostCommentsByPostId(String postId, int page,int size);

  Future<List<LikeEntity>> getPostLikes(String postId, int count);

  Future<CommentEntity> createComment(String postId, String comment);
}
