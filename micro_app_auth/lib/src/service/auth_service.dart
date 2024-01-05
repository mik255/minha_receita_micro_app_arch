import 'package:micro_app_common/micro_app_common.dart';
import 'package:micro_app_core/micro_app_core.dart';
import '../data/auth_repository.dart';

class AuthService {
  AuthRepositoryImp authRepositoryImp;
  EventBusService eventBusService;

  AuthService(
    this.authRepositoryImp,
    this.eventBusService,
  ) {
    auth();
  }

  void auth() async {
    eventBusService.on<AuthEvent>((event) async {
      var response = await authRepositoryImp.auth(event.credentials);
      eventBusService.emit<AuthenticatedEvent>(AuthenticatedEvent(response));
    });
  }
}
