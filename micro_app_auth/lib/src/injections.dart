import 'package:micro_app_auth/src/service/auth_service.dart';
import 'package:micro_app_core/micro_app_core.dart';

import 'data/auth_repository.dart';

class AuthInjections {
  EventBusService eventBusService;
  CoreHttp coreHttp;

  AuthInjections(this.eventBusService, this.coreHttp);

  init() {
    AuthService(
      AuthRepositoryImp(coreHttp),
      eventBusService,
    );
  }
}
