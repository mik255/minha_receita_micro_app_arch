import '../../micro_app_common.dart';

class AuthEvent {
  Credentials credentials;

  AuthEvent(this.credentials);
}

class AuthenticatedEvent {
  Account account;

  AuthenticatedEvent(this.account);
}
