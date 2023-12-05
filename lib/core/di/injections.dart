

import 'package:get_it/get_it.dart';

import '../common_http/common_http.dart';

class AppInjections{
  var getIt = GetIt.instance;
  init(){
    getIt.registerSingleton<CommonHttp>(CommonHttp());
  }
}