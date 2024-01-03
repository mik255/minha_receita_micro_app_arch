import 'package:micro_app_common/micro_app_common.dart';
import 'package:micro_app_core/micro_app_core.dart';
import 'package:micro_app_home/src/presenter/store/home_store.dart';

import 'data/datasource/feed_datasource.dart';
import 'data/repository/feed_repository.dart';
import 'domain/repository/post_repository.dart';
import 'domain/usecases/post_usecases.dart';


class HomeInjections {
  GetIt getIt = GetIt.instance;

  void init() {
    _registerDataSources();
    _registerRepositories();
    _registerUseCases();
    _registerStores();
    navigateListeners();
  }

  void _registerDataSources() {
    getIt.registerSingleton<FeedDataSource>(FeedDataSourceImpl(
      getIt<CoreHttp>(),
    ));
  }

  void _registerRepositories() {
    getIt.registerSingleton<PostRepository>(
      FeedRepositoryImpl(
        feedDataSource: getIt<FeedDataSource>(),
      ),
    );
  }

  void _registerUseCases() {
    getIt.registerSingleton<PostUseCases>(
      GetPostUseCasesImpl(
        postRepository: getIt<PostRepository>(),
      ),
    );
  }

  void _registerStores() {
    getIt.registerSingleton<HomeStore>(HomeStore(
      postUseCases: getIt<PostUseCases>(),
    ));
  }

  void navigateListeners() {
    var eventBusService = getIt<EventBusService>();
    eventBusService.on<AccountAuthenticatedEvent>((event) {
      CommonNavigator.navigateKey.currentState!
          .pushReplacementNamed('/home/main');
    });
  }
}
