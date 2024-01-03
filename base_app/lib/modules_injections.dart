import 'package:micro_app_account/micro_app_account.dart';
import 'package:micro_app_auth/micro_app_auth.dart';
import 'package:micro_app_common/micro_app_common.dart';
import 'package:micro_app_core/micro_app_core.dart';
import 'package:micro_app_home/micro_app_home.dart';
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
    HomeInjections().init();
    AccountInjections().init();

    AuthInjections(getIt<EventBusService>(), getIt<CoreHttp>()).init();
  }
}
