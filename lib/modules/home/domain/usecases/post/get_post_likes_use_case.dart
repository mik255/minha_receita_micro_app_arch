import '../../model/post_entity.dart';
import '../../repository/post_repository.dart';

abstract class GetPostLikesUseCase {
  late int count;

  Future<PostEntity> call(PostEntity feedEntity);
}

class GetPostLikesUseCaseImpl implements GetPostLikesUseCase {
  final PostRepository _postRepository;

  GetPostLikesUseCaseImpl({required PostRepository postRepository})
      : _postRepository = postRepository;

  @override
  int count = 0;

  @override
  Future<PostEntity> call(PostEntity postEntity) async {
    count += 5;
    final likesList = await _postRepository.getPostLikes(postEntity.id, count);
    postEntity.likesList = likesList;
    return postEntity;
  }
}
