import '../model/comment_entity.dart';
import '../model/like_entity.dart';
import '../model/post_entity.dart';
import '../repository/post_repository.dart';

abstract class PostUseCases {
  Future<List<PostEntity>> getList(int page, int size);

  Future<List<LikeEntity>> getLikes(PostEntity feedEntity, int page, int size);

  Future<void> createLike(PostEntity feedEntity, LikeEntity like);

  Future<List<CommentEntity>> getComments(
      PostEntity feedEntity, int page, int size);

  Future<void> createComment(PostEntity feedEntity, CommentEntity comment);

  Future<void> removeLike(PostEntity post, LikeEntity like);
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
    feedEntity.commentsCount++;
    feedEntity.commentsList.add(result);
  }

  @override
  Future<void> createLike(
    PostEntity feedEntity,
    LikeEntity like,
  ) async {
    await _postRepository.createLike(feedEntity.id, like);
    feedEntity.likesList.add(like);
    feedEntity.likesList.toSet().toList();
    feedEntity.likesCount++;
  }

  @override
  Future<List<CommentEntity>> getComments(
    PostEntity feedEntity,
    int page,
    int size,
  ) async {
    var comments = await _postRepository.getCommentsByPostId(
      feedEntity.id,
      page,
      size,
    );
    feedEntity.commentsList.addAll(comments);
    feedEntity.commentsList.toSet().toList();
    feedEntity.commentsList.sort(
      (a, b) => DateTime.parse(b.createdAt).compareTo(
        DateTime.parse(a.createdAt),
      ),
    );
    feedEntity.commentsCount = feedEntity.commentsList.length - 1;
    if (feedEntity.commentsCount < 0) feedEntity.commentsCount = 0;

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
    Map<String, LikeEntity> list = {};
    for (var element in feedEntity.likesList) {
      list[element.name] = element;
    }
    feedEntity.likesList = list.values.toList();
    return likes;
  }

  @override
  Future<void> removeLike(PostEntity post, LikeEntity like) async {
    await _postRepository.removeLike(post.id, like);
    post.likesList.remove(like);
    post.likesList.toSet().toList();
    post.likesCount--;
    if (post.likesCount < 0) post.likesCount = 0;
  }
}
