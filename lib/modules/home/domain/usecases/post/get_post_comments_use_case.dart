import 'package:minha_receita/modules/home/domain/model/post_entity.dart';
import '../../repository/post_repository.dart';

abstract class GetPostCommentsUseCase {
  Future<PostEntity> call(PostEntity feedEntity,int page);
}

class GetPostCommentsUseCaseImpl implements GetPostCommentsUseCase {
  final HomeFeedRepository _postRepository;

  GetPostCommentsUseCaseImpl({required HomeFeedRepository postRepository})
      : _postRepository = postRepository;

  @override
  Future<PostEntity> call(PostEntity postEntity, int page) async {
    // var comments = await _postRepository.getPostCommentsByPostId(
    //   postEntity.id,
    //   page,
    // );
   // postEntity.comments.addAll(comments);
    return postEntity;
  }
}
