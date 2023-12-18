import 'package:minha_receita/modules/home/domain/model/post_entity.dart';

import '../../repository/post_repository.dart';

abstract class GetListPostUseCase {
  Future<List<PostEntity>> call(int page,int size);
}

class GetListPostUseCaseImpl implements GetListPostUseCase {
  final HomeFeedRepository _feedRepository;

  GetListPostUseCaseImpl({required HomeFeedRepository feedRepository})
      : _feedRepository = feedRepository;

  @override
  Future<List<PostEntity>> call(int page,int size) async {
    return await _feedRepository.getPostList(page,size);
  }
}
