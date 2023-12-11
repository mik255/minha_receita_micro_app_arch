import '../models/account.dart';
import '../models/credentials.dart';
import '../repository/account_repository.dart';

abstract class LoginUseCase {
  Future<Account> call(Credentials params);
}

class LoginUseCaseImpl implements LoginUseCase {
  final AccountRepository repository;

  LoginUseCaseImpl(this.repository);

  @override
  Future<Account> call(Credentials credentials) async {
    credentials.emailValidate();
    credentials.passwordValidate();
    return await repository.login(credentials);
  }
}
