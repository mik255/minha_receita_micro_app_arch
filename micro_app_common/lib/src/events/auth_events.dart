import 'package:micro_app_core/micro_app_core.dart';

import '../../micro_app_common.dart';

class AuthEvent implements EventData {
  Credentials credentials;

  AuthEvent(this.credentials);

  @override
  Map<String,dynamic> toJson() {
    return credentials.toJson();
  }
}

class AuthenticatedEvent implements EventData {
  Account account;

  AuthenticatedEvent(this.account);

  @override
  Map<String,dynamic> toJson() {
    return account.toJson();
  }
}
