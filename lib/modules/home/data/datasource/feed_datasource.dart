import 'package:flutter/foundation.dart';
import 'package:minha_receita/modules/home/domain/model/feed_entity.dart';
import '../../../../../core/common_http/common_http.dart';

abstract class FeedDataSource {
  Future<List<FeedEntity>> getListFeed();
}

class FeedDataSourceImpl implements FeedDataSource {
  @override
  Future<List<FeedEntity>> getListFeed() async {
    var response = await CommonHttp.instance!.get(
      route: '/feeds',
    );
    try {
      return (response.data as List)
          .map((e) => FeedEntity.fromJson(e))
          .toList();
    } catch (e,_) {
      if(kDebugMode){
        print(e);
        print(_);
      }
      rethrow;
    }
  }
}
