import 'package:get_it/get_it.dart';

import '../../core/drivers/camera_access.dart';
import 'drivers/camera_access_impl.dart';
import 'user/domain/models/user.dart';

class CommonInjections {
  GetIt getIt = GetIt.instance;

  void init() {
    _registerUseCases();
  }

  void _registerUseCases() {
    getIt.registerSingleton<UserModel>(
      UserModel(
        id: '123',
        name: 'Mikael Rocha',
        avatarImgUrl: 'https://source.unsplash.com/random/80x600/?person_icon',
      ),
    );
    getIt.registerLazySingleton<DeviceDataAccess>(() => CameraAccessImpl());
  }
}