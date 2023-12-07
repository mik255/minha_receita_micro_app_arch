import 'package:get_it/get_it.dart';
import 'package:minha_receita/core/config/config.dart';

import '../../modules/home/core/di/injections.dart';
import '../../modules/recipe/core/di/injections.dart';
import '../common_http/common_http.dart';

class AppInjections {
  var getIt = GetIt.instance;

  init() {
    getIt.registerSingleton<CommonHttp>(CommonHttp(
      baseUrl: baseUrl,
    ));
    RecipeInjections().init();
    HomeInjections().init();
  }
}
