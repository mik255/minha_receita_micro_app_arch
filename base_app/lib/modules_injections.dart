import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:minha_receita/modules/init/module.dart';
import 'common/http/data/common_http.dart';
import 'common/injections.dart';
import 'core/http/core_http.dart';
import 'core/services/event_bus.dart';
import 'modules/account/data/repository/account_repository.dart';
import 'modules/account/module.dart';
import 'modules/home/module.dart';
import 'modules/post/injections.dart';
import 'modules/recipe/injections.dart';

class AppInjections {
  var getIt = GetIt.instance;

  init() {
    getIt.registerSingleton<CoreHttp>(CommonHttp(
      baseUrl: CommonInjections.baseUrl,
    ));
    CommonInjections().init();
    RecipeInjections().init();
    PostInjections().init();
    getIt.registerSingleton<IAccountRepository>(AuthRepositoryImp(
      getIt.get(),
    ));
  }
}

class AppModule extends Module {
  @override
  List<Bind> get binds => [
    Bind<CoreHttp>((i) => CommonHttp(
      baseUrl: CommonInjections.baseUrl,
    )),
    Bind<IAccountRepository>((i) => AuthRepositoryImp(
      i.get(),
    )),
  ];

  @override
  List<ModularRoute> get routes => [
    ModuleRoute(
      '/',
      module: InitModule(),
    ),
    ModuleRoute(
      '/account',
      module: AccountModule(),
    ),  ModuleRoute(
      '/home',
      module: HomeModule(),
    ),
  ];
}