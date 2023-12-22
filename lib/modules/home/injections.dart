import 'package:get_it/get_it.dart';
import 'package:minha_receita/modules/home/data/datasource/feed_datasource.dart';
import 'package:minha_receita/modules/home/data/repository/feed_repository.dart';
import 'package:minha_receita/modules/home/presenter/store/home_store.dart';
import '../../core/http/core_http.dart';
import 'domain/repository/post_repository.dart';
import 'domain/usecases/post_usecases.dart';

class HomeInjections {
  GetIt getIt = GetIt.instance;

  void init() {
    _registerDataSources();
    _registerRepositories();
    _registerUseCases();
    _registerStores();
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
}
