

import '../../core/services/event_bus.dart';
import '../models/account.dart';

class AccountAuthenticatedEvent implements EventData{
  @override
  Map<String,dynamic> toJson() {
    return {};
  }
}

class GetAccountEvent implements EventData{
  GetAccountEvent(this.account);
  Account account;
  @override
  Map<String,dynamic> toJson() {
    return {};
  }
}