import '../repository/account_repository.dart';

abstract class SendConfirmRegisterCodeUseCase {
  Future<void> call();
}

class SendConfirmRegisterCodeUseCaseImpl
    implements SendConfirmRegisterCodeUseCase {
  final AccountRepository repository;

  SendConfirmRegisterCodeUseCaseImpl(this.repository);

  @override
  Future<void> call() async {
    await repository.sendConfirmRegister();
  }
}
