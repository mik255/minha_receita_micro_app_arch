import 'package:minha_receita/modules/home/domain/model/post_entity.dart';

import '../../repository/post_repository.dart';

abstract class GetListPostUseCase {
  Future<List<PostEntity>> call();
}

class GetListPostUseCaseImpl implements GetListPostUseCase {
  final PostRepository _feedRepository;

  GetListPostUseCaseImpl({required PostRepository feedRepository})
      : _feedRepository = feedRepository;

  @override
  Future<List<PostEntity>> call() async {
    return await _feedRepository.getPostList();
  }
}
