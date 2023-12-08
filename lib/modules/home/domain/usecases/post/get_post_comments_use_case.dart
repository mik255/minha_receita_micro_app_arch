import 'package:minha_receita/modules/home/domain/model/post_entity.dart';
import '../../repository/post_repository.dart';

abstract class GetPostCommentsUseCase {
  Future<PostEntity> call(PostEntity feedEntity);
}

class GetPostCommentsUseCaseImpl implements GetPostCommentsUseCase {
  final PostRepository _postRepository;

  GetPostCommentsUseCaseImpl({required PostRepository postRepository})
      : _postRepository = postRepository;

  int count = 5;

  ///começa com 5 e vai aumentando de 5 em 5 conforme o usuário vai descendo a lista
  @override
  Future<PostEntity> call(PostEntity postEntity) async {
    count += 5;
    var comments = await _postRepository.getPostCommentsByPostId(
      postEntity.id,
      count,
    );
    postEntity.comments = comments;
    return postEntity;
  }
}
