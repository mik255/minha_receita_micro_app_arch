import '../models/credentials.dart';
import '../repository/account_repository.dart';

abstract class LoginUseCase {
  Future<void> call(Credentials params);
}

class LoginUseCaseImpl implements LoginUseCase {
  final AccountRepository repository;

  LoginUseCaseImpl(this.repository);

  @override
  Future<void> call(Credentials credentials) async {
    credentials.emailValidate();
    credentials.passwordValidate();
    await repository.login(credentials);
  }
}
