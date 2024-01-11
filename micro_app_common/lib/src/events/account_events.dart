import 'package:micro_app_common/micro_app_common.dart';
import 'package:micro_app_core/micro_app_core.dart';

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