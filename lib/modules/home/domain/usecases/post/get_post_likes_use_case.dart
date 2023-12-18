import '../../model/post_entity.dart';
import '../../repository/post_repository.dart';

abstract class GetPostLikesUseCase {
  Future<PostEntity> call(PostEntity feedEntity,int page);
}

class GetPostLikesUseCaseImpl implements GetPostLikesUseCase {
  final HomeFeedRepository _postRepository;

  GetPostLikesUseCaseImpl({required HomeFeedRepository postRepository})
      : _postRepository = postRepository;

  @override
  Future<PostEntity> call(PostEntity postEntity,int page) async {
    final likesList = await _postRepository.getPostLikes(postEntity.id, page);
    postEntity.likesList.addAll(likesList);
    return postEntity;
  }
}
