// import 'package:minha_receita/modules/account/domain/models/account.dart';
//
// import 'package:minha_receita/modules/auth/models/credentials.dart';
//
// import '../../domain/repository/account_repository.dart';
// import '../datasource/account_datasource.dart';
//
// class AccountRepositoryImp implements AccountRepository {
//   final AccountDataSource accountDataSource;
//
//   AccountRepositoryImp(this.accountDataSource);
//
//   @override
//   Future<void> deleteAccount() {
//     // TODO: implement deleteAccount
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<Account> login(Credentials credentials) {
//     return accountDataSource.login(credentials);
//   }
//
//   @override
//   Future<void> logout() {
//     // TODO: implement logout
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<Account> register(Credentials credentials) {
//     return accountDataSource.register(credentials);
//   }
//
//   @override
//   Future<bool> registerCodeVerification(String code) {
//     return accountDataSource.registerCodeVerification(code);
//   }
//
//   @override
//   Future<bool> sendConfirmRegister() {
//     return accountDataSource.sendConfirmRegisterCode();
//   }
// }
