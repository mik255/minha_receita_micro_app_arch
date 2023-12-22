import 'package:minha_receita/modules/home/domain/model/comment_entity.dart';
import 'package:minha_receita/modules/home/domain/model/post_entity.dart';

import '../model/like_entity.dart';
import '../repository/post_repository.dart';

abstract class PostUseCases {
  Future<List<PostEntity>> getList(int page, int size);

  Future<List<LikeEntity>> getLikes(PostEntity feedEntity, int page, int size);

  Future<void> createLike(PostEntity feedEntity, LikeEntity like);

  Future<List<CommentEntity>> getComments(
      PostEntity feedEntity, int page, int size);

  Future<void> createComment(PostEntity feedEntity, CommentEntity comment);
}

class GetPostUseCasesImpl implements PostUseCases {
  final PostRepository _postRepository;

  GetPostUseCasesImpl({required PostRepository postRepository})
      : _postRepository = postRepository;

  @override
  Future<List<PostEntity>> getList(
    int page,
    int size,
  ) async {
    var list = await _postRepository.getPostList(page, size);
    list = list.toSet().toList();
    list.sort((a, b) =>
        DateTime.parse(b.createdAt!).compareTo(DateTime.parse(a.createdAt!)));
    return list;
  }

  @override
  Future<void> createComment(
    PostEntity feedEntity,
    CommentEntity comment,
  ) async {
    var result = await _postRepository.createComment(feedEntity.id, comment);
    feedEntity.commentsList.add(result);
  }

  @override
  Future<void> createLike(
    PostEntity feedEntity,
    LikeEntity like,
  ) async {
    var result = await _postRepository.createLike(feedEntity.id, like);
    feedEntity.likesList.add(result);
  }

  @override
  Future<List<CommentEntity>> getComments(
    PostEntity feedEntity,
    int page,
    int size,
  ) async {
    var comments = await _postRepository.getCommentsByPostId(feedEntity.id, page, size);
    feedEntity.commentsList.addAll(comments);
    feedEntity.commentsList.toSet().toList();
    feedEntity.commentsList.sort((a, b) =>
        DateTime.parse(b.createdAt).compareTo(DateTime.parse(a.createdAt)));
    feedEntity.commentsCount = feedEntity.commentsList.length - 1;
    if(feedEntity.commentsCount < 0) feedEntity.commentsCount = 0;
    return comments;
  }

  @override
  Future<List<LikeEntity>> getLikes(
    PostEntity feedEntity,
    int page,
    int size,
  ) async {
    var likes = await _postRepository.getPostLikes(feedEntity.id, page, size);
    feedEntity.likesList.addAll(likes);
    feedEntity.likesList.toSet().toList();
    feedEntity.likesCount++;
    return likes;
  }
}
