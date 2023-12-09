import 'package:minha_receita/modules/account/domain/models/account.dart';

import 'package:minha_receita/modules/account/domain/models/credentials.dart';

import '../../domain/repository/account_repository.dart';
import '../datasource/account_datasource.dart';

class AccountRepositoryImp implements AccountRepository {
  final AccountDataSource accountDataSource;

  AccountRepositoryImp(this.accountDataSource);

  @override
  Future<void> deleteAccount() {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<void> login(Credentials credentials) {
    return accountDataSource.login(credentials);
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> saveAccount(Account account) {
    // TODO: implement saveAccount
    throw UnimplementedError();
  }
}
