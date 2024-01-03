import 'package:get_it/get_it.dart';
import 'package:micro_app_account/src/presenter/store/login_store.dart';
import 'package:micro_app_core/micro_app_core.dart';

class AccountInjections {
  GetIt getIt = GetIt.instance;

  void init() {
    // _registerDataSources();
    // _registerRepositories();
    // _registerUseCases();
    _registerStores();
  }

  // void _registerDataSources() {
  //   getIt.registerSingleton<AccountDataSource>(LoginDataSourceImpl(
  //     getIt<CoreHttp>(),
  //   ));
  // }
  //
  // void _registerRepositories() {
  //   getIt.registerSingleton<AccountRepository>(
  //     AccountRepositoryImp(
  //       getIt<AccountDataSource>(),
  //     ),
  //   );
  // }
  //
  // void _registerUseCases() {
  //   getIt.registerSingleton<LoginUseCase>(
  //     LoginUseCaseImpl(
  //       getIt<AccountRepository>(),
  //     ),
  //   );
  //   getIt.registerSingleton<RegisterUseCase>(
  //     RegisterUseCaseImpl(
  //       getIt<AccountRepository>(),
  //     ),
  //   );
  // }

  void _registerStores() {
    getIt.registerSingleton<LoginStore>(LoginStore(
      getIt<EventBusService>(),
    ));
  }
}
