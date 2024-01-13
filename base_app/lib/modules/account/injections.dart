import 'package:get_it/get_it.dart';
import 'package:minha_receita/modules/account/presenter/store/login_store.dart';

import '../auth/cubit/auth_cubit.dart';

class AccountInjections {
  GetIt getIt = GetIt.instance;

  void init() {
    _registerStores();
  }

  void _registerStores() {
    getIt.registerSingleton<LoginStore>(LoginStore());
  }
}
