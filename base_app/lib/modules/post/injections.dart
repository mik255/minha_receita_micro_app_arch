import 'package:get_it/get_it.dart';

import 'package:minha_receita/modules/post/domain/usecases/post_usecases.dart';
import 'package:minha_receita/modules/post/presenter/store/post_store.dart';
import '../../core/http/core_http.dart';
import 'data/datasource/post_datasource.dart';
import 'data/repository_impl/post_repository_impl.dart';
import 'domain/repository/post_repository.dart';

class PostInjections {
  var getIt = GetIt.instance;

  init() {
    getIt.registerSingleton<PostDataSource>(PostDataSourceImpl(
      getIt<CoreHttp>(),
    ));
    getIt.registerSingleton<PostRepository>(PostRepositoryImpl(
      getIt<PostDataSource>(),
    ));
    getIt.registerSingleton<PostUseCase>(PostUseCaseImpl(
      getIt<PostRepository>(),
    ));
    getIt.registerSingleton<PostStore>(PostStore(
      getIt<PostUseCase>(),
    ));
  }
}
