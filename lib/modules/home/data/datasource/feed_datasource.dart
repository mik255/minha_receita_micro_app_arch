import 'package:minha_receita/modules/home/domain/model/comment_entity.dart';
import 'package:minha_receita/modules/home/domain/model/post_entity.dart';
import 'package:minha_receita/modules/home/domain/model/like_entity.dart';
import '../../../../core/http/core_http.dart';
import '../../../../core/mappers/lists.dart';

abstract class FeedDataSource {
  Future<List<PostEntity>> getListPost(int page,int size);

  Future<List<CommentEntity>> getPostComments(String postId, int page,int size);

  Future<List<LikeEntity>> getPostLikes(String feedId, int page,int size);

  Future<CommentEntity> createComment(String postId, CommentEntity comment);

  void createLike(id, LikeEntity like);
}

class FeedDataSourceImpl implements FeedDataSource {
  CoreHttp coreHttp;

  FeedDataSourceImpl(this.coreHttp);

  @override
  Future<List<PostEntity>> getListPost(int page,int size) async {
    var response = await coreHttp.get(
      route: '/posts',
      queryParameters: {
        'page': page,
        'size': size,
      },
    );
    return coreMappersParseList(response.data, (e) => PostEntity.fromJson(e));
  }

  @override
  Future<List<CommentEntity>> getPostComments(String postId, int page,int size) async {
    var response = await coreHttp.get(
      route: '/comment',
      queryParameters: {
        'postId': postId,
        'page': page,
        'size': size,
      },
    );
    return coreMappersParseList(
      response.data,
      (e) => CommentEntity.fromJson(e),
    );
  }

  @override
  Future<List<LikeEntity>> getPostLikes(String id, int page,int size) async {
    var response = await coreHttp.get(
      route: '/likes',
      queryParameters: {
        'postId': id,
        'page': page,
        'size': size,
      },
    );
    return coreMappersParseList(
      response.data,
      (e) => LikeEntity.fromJson(e),
    );
  }

  @override
  Future<CommentEntity> createComment(String postId, CommentEntity comment) async{
    var response = await coreHttp.post(
      route: '/comment',
      body: {
        "postId": postId,
        "comment":comment.comment
      }
    );
    return CommentEntity.fromJson(response.data);
  }

  @override
  void createLike(id, LikeEntity like) async{
    await coreHttp.post(
      route: '/likes',
      body: {
        "postId":id
      }
    );
  }
}
