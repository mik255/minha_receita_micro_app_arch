import 'package:get_it/get_it.dart';
import 'package:minha_receita/common/services/event_bus_service_impl.dart';
import '../core/drivers/camera_access.dart';
import '../core/services/event_bus.dart';
import 'services/camera_service.dart';

class CommonInjections {
  GetIt getIt = GetIt.instance;
  static String get baseUrl => const String.fromEnvironment('baseUrl',
      defaultValue: 'http://10.0.2.2:8080/api');
  void init() {
    _registerUseCases();
  }

  void _registerUseCases() {
    getIt.registerLazySingleton<ICameraService>(() => CameraService());
    getIt.registerLazySingleton<EventBusService>(() => EventBusServiceImpl());
  }
}
