import '../../core/services/event_bus.dart';
import '../models/account.dart';
import '../models/credentials.dart';

class AuthEvent implements EventData {
  Credentials credentials;

  AuthEvent(this.credentials);

  @override
  Map<String, dynamic> toJson() {
    return credentials.toJson();
  }
}

class AuthenticatedEvent implements EventData {
  Account account;

  AuthenticatedEvent(this.account);

  @override
  Map<String, dynamic> toJson() {
    return account.toJson();
  }
}
