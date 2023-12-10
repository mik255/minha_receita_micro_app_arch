import 'package:minha_receita/modules/home/domain/model/comment_entity.dart';
import 'package:minha_receita/modules/home/domain/model/post_entity.dart';
import 'package:minha_receita/modules/home/domain/model/like_entity.dart';
import '../../../../core/http/core_http.dart';
import '../../../../core/mappers/lists.dart';

abstract class PostDataSource {
  Future<List<PostEntity>> getListPost();

  Future<List<CommentEntity>> getPostComments(String feedId, int count);

  Future<List<LikeEntity>> getPostLikes(String feedId, int count);
}

class PostDataSourceImpl implements PostDataSource {
  CoreHttp coreHttp;

  PostDataSourceImpl(this.coreHttp);

  @override
  Future<List<PostEntity>> getListPost() async {
    var response = await coreHttp.get(
      route: '/feeds',
    );
    return coreMappersParseList(response.data, (e) => PostEntity.fromJson(e));
  }

  @override
  Future<List<CommentEntity>> getPostComments(String id, int count) async {
    var response = await coreHttp.get(
      route: '/comments/$id?total=10',
    );
    return coreMappersParseList(
      response.data,
      (e) => CommentEntity.fromJson(e),
    );
  }

  @override
  Future<List<LikeEntity>> getPostLikes(String id, int count) async {
    var response = await coreHttp.get(
      route: '/likes/$id?total=10',
    );
    return coreMappersParseList(
      response.data,
      (e) => LikeEntity.fromJson(e),
    );
  }
}
