import 'package:minha_receita/modules/home/domain/model/feed_entity.dart';

import '../repository/feed_repository.dart';

abstract class GetListFeedUseCase {
  Future<List<FeedEntity>> call();
}

class GetListFeedUseCaseImpl implements GetListFeedUseCase {
  final FeedRepository _feedRepository;

  GetListFeedUseCaseImpl({required FeedRepository feedRepository})
      : _feedRepository = feedRepository;

  @override
  Future<List<FeedEntity>> call() async {
    return await _feedRepository.getListFeed();
  }
}
