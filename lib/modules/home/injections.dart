import 'package:get_it/get_it.dart';
import 'package:minha_receita/modules/home/data/datasource/feed_datasource.dart';
import 'package:minha_receita/modules/home/data/repository/feed_repository.dart';
import 'package:minha_receita/modules/home/presenter/store/comments_store/comments_store.dart';
import 'package:minha_receita/modules/home/presenter/store/likes_store/likes_store.dart';

import '../../core/http/core_http.dart';
import 'domain/repository/post_repository.dart';

import 'domain/usecases/post/comments_use_case.dart';
import 'domain/usecases/post/get_post_likes_use_case.dart';
import 'domain/usecases/post/get_post_list_use_case.dart';
import 'presenter/store/feed_store/feed_store.dart';

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
    getIt.registerSingleton<HomeFeedRepository>(
      FeedRepositoryImpl(
        feedDataSource: getIt<FeedDataSource>(),
      ),
    );
  }

  void _registerUseCases() {
    getIt.registerSingleton<GetListPostUseCase>(
      GetListPostUseCaseImpl(
        feedRepository: getIt<HomeFeedRepository>(),
      ),
    );
    getIt.registerSingleton<GetPostCommentsUseCase>(
      GetPostCommentsUseCaseImpl(
        postRepository: getIt<HomeFeedRepository>(),
      ),
    );

    getIt.registerSingleton<GetPostLikesUseCase>(
      GetPostLikesUseCaseImpl(
        postRepository: getIt<HomeFeedRepository>(),
      ),
    );
  }

  void _registerStores() {
    getIt.registerSingleton<FeedStore>(FeedStore(
      getListFeedUseCase: getIt<GetListPostUseCase>(),
      getFeedCommentsUseCase: getIt<GetPostCommentsUseCase>(),
    ));
    getIt.registerSingleton<CommentsStore>(CommentsStore(
      getFeedCommentsUseCase: getIt<GetPostCommentsUseCase>(),
    ));
    getIt.registerSingleton<LikesStore>(LikesStore(
      getFeedLikesUseCase: getIt<GetPostLikesUseCase>(),
    ));
  }
}
