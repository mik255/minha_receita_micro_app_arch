import 'package:minha_receita/modules/home/domain/model/feed_entity.dart';
import 'package:minha_receita/modules/home/domain/repository/feed_repository.dart';

import '../datasource/feed_datasource.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedDataSource _feedDataSource;

  FeedRepositoryImpl({required FeedDataSource feedDataSource})
      : _feedDataSource = feedDataSource;

  @override
  Future<List<FeedEntity>> getListFeed() async {
    return await _feedDataSource.getListFeed();
  }
}
