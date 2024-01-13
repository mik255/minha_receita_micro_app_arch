import 'package:get_it/get_it.dart';
import 'package:minha_receita/modules/auth/auth_repository.dart';

import '../../core/http/core_http.dart';
import 'cubit/auth_cubit.dart';

class AuthInjections {
  GetIt getIt = GetIt.instance;
  CoreHttp coreHttp;

  AuthInjections(this.coreHttp);

  init() {
    getIt.registerSingleton<AuthCubit>(AuthCubit(
      AuthRepositoryImp(coreHttp),
    ));
  }
}
