import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:minha_receita/modules/account/presenter/cubit/auth_cubit.dart';
import 'package:minha_receita/modules/init/module.dart';
import 'package:minha_receita/modules/register_recipe/services/register_recipe_service.dart';
import 'common/http/data/common_http.dart';
import 'common/injections.dart';
import 'core/http/core_http.dart';
import 'modules/account/data/repository/account_repository.dart';
import 'modules/account/module.dart';
import 'modules/home/data/repository/home_repository.dart';
import 'modules/home/module.dart';
import 'modules/post/injections.dart';
import 'modules/register_recipe/data/repository/recipe_repository.dart';

class AppInjections {
  var getIt = GetIt.instance;

  init() {
    getIt.registerSingleton<CoreHttp>(CommonHttp(
      baseUrl: CommonInjections.baseUrl,
    ));
    CommonInjections().init();
    PostInjections().init();
    getIt.registerSingleton<IAccountRepository>(AccountRepositoryImp(
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
        Bind<IAccountRepository>((i) => AccountRepositoryImp(
              i.get(),
            )),
        Bind.singleton<HomeRepository>(
          (i) => HomeRepositoryImpl(
            i.get(),
          ),
        ),
        Bind.singleton<AccountCubit>(
            (i) => AccountCubit(
                  i.get(),
                ),
            onDispose: (bloc) => bloc.close()),
        Bind.singleton<RegisterRecipeService>((i) => RegisterRecipeService()),
        Bind.singleton<RecipeRepository>((i) => RecipeRepository(
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
        ),
        ModuleRoute(
          '/home',
          module: HomeModule(),
        ),
      ];
}
