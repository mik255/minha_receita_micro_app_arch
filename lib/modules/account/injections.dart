import 'package:get_it/get_it.dart';
import '../../core/http/core_http.dart';
import 'data/datasource/account_datasource.dart';
import 'data/repository/account_repository.dart';
import 'domain/repository/account_repository.dart';
import 'domain/usecases/login_usecase.dart';
import 'presenter/store/login_store.dart';

class AccountInjections {
  GetIt getIt = GetIt.instance;

  void init() {
    _registerDataSources();
    _registerRepositories();
    _registerUseCases();
    _registerStores();
  }

  void _registerDataSources() {
    getIt.registerSingleton<AccountDataSource>(LoginDataSourceImpl(
      getIt<CoreHttp>(),
    ));
  }

  void _registerRepositories() {
    getIt.registerSingleton<AccountRepository>(
      AccountRepositoryImp(
        getIt<AccountDataSource>(),
      ),
    );
  }

  void _registerUseCases() {
    getIt.registerSingleton<LoginUseCase>(
      LoginUseCaseImpl(
        getIt<AccountRepository>(),
      ),
    );
  }

  void _registerStores() {
    getIt.registerSingleton<LoginStore>(LoginStore(
      getIt<LoginUseCase>(),
    ));
  }
}
