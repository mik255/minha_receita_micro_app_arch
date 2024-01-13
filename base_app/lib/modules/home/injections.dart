import 'package:get_it/get_it.dart';

import 'package:minha_receita/modules/home/presenter/store/home_store.dart';

import '../../common/events/account_events.dart';
import '../../common/models/account.dart';
import '../../common/navigator/navigator.dart';
import '../../core/http/core_http.dart';
import '../../core/services/event_bus.dart';
import 'data/datasource/feed_datasource.dart';
import 'data/repository/feed_repository.dart';
import 'domain/repository/post_repository.dart';
import 'domain/usecases/post_usecases.dart';

class HomeInjections {
  static Account? account;
  GetIt getIt = GetIt.instance;
  EventBusService eventBusService;

  HomeInjections(this.eventBusService);

  void init() {
    _registerDataSources();
    _registerRepositories();
    _registerUseCases();
    _registerStores();
    events();
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

  void events() {
    var eventBusService = getIt<EventBusService>();
    eventBusService.on<GetAccountEvent>((event) {
      account = event.account;
    });

    eventBusService.on<AccountAuthenticatedEvent>((
      event,
    ) async {
      CommonNavigator.navigateKey.currentState!
          .pushReplacementNamed('/home/main');
    });
  }
}
