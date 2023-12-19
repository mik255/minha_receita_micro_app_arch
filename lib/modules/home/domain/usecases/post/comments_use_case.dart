import 'package:minha_receita/modules/home/domain/model/comment_entity.dart';
import '../../repository/post_repository.dart';

abstract class GetPostCommentsUseCase {
  Future<List<CommentEntity>> getComments(String postId, int page, int size);
  Future<CommentEntity> createComment(String postId, String comment);
}

class GetPostCommentsUseCaseImpl implements GetPostCommentsUseCase {
  final HomeFeedRepository _postRepository;

  GetPostCommentsUseCaseImpl({required HomeFeedRepository postRepository})
      : _postRepository = postRepository;

  @override
  Future<List<CommentEntity>> getComments(String postId, int page, int size) async {
    var comments =
        await _postRepository.getPostCommentsByPostId(postId, page, size);
    return comments;
  }

  @override
  Future<CommentEntity> createComment(String postId, String comment) async{
    var comments = await _postRepository.createComment(postId,comment);
    return comments;
  }
}
