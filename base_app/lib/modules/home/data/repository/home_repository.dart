import '../../../../core/http/core_http.dart';
import '../../../../core/mappers/lists.dart';
import '../../model/comment_entity.dart';
import '../../model/like_entity.dart';
import '../../model/post_entity.dart';
import '../../model/stories_entity.dart';

abstract class HomeRepository {
  Future<List<UserStore>> getStories(int page, int size);

  Future<List<PostEntity>> getListPost(int page, int size);

  Future<List<CommentEntity>> getPostComments(
    String postId,
    int page,
    int size,
  );

  Future<List<LikeEntity>> getPostLikes(String feedId, int page, int size);

  Future<void> createComment(String postId, String comment);

  Future<void> createLike(String postId);

  Future<void> removeLike(String postId);
}

class HomeRepositoryImpl implements HomeRepository {
  CoreHttp coreHttp;

  HomeRepositoryImpl(this.coreHttp);

  @override
  Future<List<PostEntity>> getListPost(int page, int size) async {
    var response = await coreHttp.get(
      route: '/feeds',
      queryParameters: {
        'page': page,
        'size': size,
      },
    );
    return coreMappersParseList(
      response.data,
      (e) => PostEntity.fromJson(e),
    );
  }

  @override
  Future<List<CommentEntity>> getPostComments(
    String postId,
    int page,
    int size,
  ) async {
    var response = await coreHttp.get(
      route: '/comments',
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
  Future<List<LikeEntity>> getPostLikes(
    String id,
    int page,
    int size,
  ) async {
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
  Future<void> createComment(
    String postId,
    String comment,
  ) async {
    var response = await coreHttp.post(route: '/comment', body: {
      "postId": postId,
      "comment": comment,
    });
  }

  @override
  Future<void> createLike(String postId) async {
    await coreHttp.post(
      route: '/like',
      body: {"postId": postId},
    );
  }

  @override
  Future<void> removeLike(String postId) async {
    await coreHttp.delete(
      route: '/like',
      queryParameters: {
        "postId": postId,
      },
    );
  }

  @override
  Future<List<UserStore>> getStories(int page, int size) async {
    var response = await coreHttp.get(
      route: '/stories',
    );
    return coreMappersParseList(
      response.data,
      (e) => UserStore.fromJson(e),
    );
  }
}
