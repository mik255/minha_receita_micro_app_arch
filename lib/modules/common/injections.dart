import 'package:get_it/get_it.dart';

import 'user/domain/models/user.dart';

class CommonInjections {
  GetIt getIt = GetIt.instance;

  void init() {
    _registerUseCases();
  }

  void _registerUseCases() {
    getIt.registerSingleton<UserModel>(
      UserModel(),
    );
  }
}
