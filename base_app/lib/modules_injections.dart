import 'package:get_it/get_it.dart';

import 'common/http/data/common_http.dart';
import 'common/injections.dart';
import 'core/http/core_http.dart';
import 'core/services/event_bus.dart';
import 'modules/account/injections.dart';
import 'modules/auth/injections.dart';
import 'modules/home/injections.dart';
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
    HomeInjections(getIt<EventBusService>()).init();
    AuthInjections(getIt<CoreHttp>()).init();
    AccountInjections().init();
  }
}
