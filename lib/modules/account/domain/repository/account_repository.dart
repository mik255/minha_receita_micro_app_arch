import 'package:minha_receita/modules/account/domain/models/credentials.dart';

import '../models/account.dart';

abstract class AccountRepository {

  Future<void> saveAccount(Account account);

  Future<void> deleteAccount();

  Future<void> login(Credentials credentials);

  Future<void> logout();

}
