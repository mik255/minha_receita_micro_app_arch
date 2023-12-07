import 'package:minha_receita/modules/home/domain/model/feed_entity.dart';

abstract class FeedRepository {
  Future<List<FeedEntity>> getListFeed();
}
