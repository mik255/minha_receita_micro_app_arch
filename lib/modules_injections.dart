import 'package:get_it/get_it.dart';
import 'package:minha_receita/core/http/core_http.dart';
import 'package:minha_receita/modules/common/injections.dart';

import 'modules/account/injections.dart';
import 'modules/common/http/data/common_http.dart';
import 'modules/home/injections.dart';
import 'modules/post/injections.dart';
import 'modules/recipe/injections.dart';

class AppInjections {
  var getIt = GetIt.instance;

  // static String get baseUrl => const String.fromEnvironment('baseUrl',
  //     defaultValue: 'http://10.0.2.2:3001');

  static String get baseUrl => const String.fromEnvironment('baseUrl',
      defaultValue: 'http://192.168.1.31:3001');

  init() {
    getIt.registerSingleton<CoreHttp>(CommonHttp(
      baseUrl: baseUrl,
    ));
    RecipeInjections().init();
    PostInjections().init();
    HomeInjections().init();
    AccountInjections().init();
    CommonInjections().init();
  }
}
