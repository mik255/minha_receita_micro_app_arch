import 'package:get_it/get_it.dart';
import 'package:minha_receita/modules/home/data/datasource/feed_datasource.dart';
import 'package:minha_receita/modules/home/data/repository/feed_repository.dart';

import '../../domain/repository/feed_repository.dart';
import '../../domain/usecases/get_list_feed.dart';
import '../../presenter/store/home_store.dart';

class HomeInjections {
  GetIt getIt = GetIt.instance;

  void init() {
    getIt.registerSingleton<FeedDataSource>(FeedDataSourceImpl());
    getIt.registerSingleton<FeedRepository>(
      FeedRepositoryImpl(
        feedDataSource: getIt<FeedDataSource>(),
      ),
    );
    getIt.registerSingleton<HomeStore>(HomeStore(
      getListFeedUseCase: GetListFeedUseCaseImpl(
        feedRepository: getIt<FeedRepository>(),
      ),
    ));
  }
}
