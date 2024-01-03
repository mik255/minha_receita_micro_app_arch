// import 'package:minha_receita/modules/account/domain/exeptions/account_exeptions.dart';
//
// import '../repository/account_repository.dart';
//
// abstract class RegisterCodeVerificationUseCase {
//   Future<void> call(String code);
//
// }
//
// class RegisterCodeVerificationUseCaseImpl
//     implements RegisterCodeVerificationUseCase {
//   final AccountRepository repository;
//
//   RegisterCodeVerificationUseCaseImpl(this.repository);
//
//   @override
//   Future<void> call(String code) async {
//     bool isValid = await repository.registerCodeVerification(code);
//     if (!isValid) {
//       throw InvalidCodeException();
//     }
//   }
// }
