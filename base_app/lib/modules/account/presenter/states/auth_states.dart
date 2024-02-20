import 'package:minha_receita/common/models/account.dart';

class AuthStates {}

class AuthInitialState extends AuthStates {}
class AuthLoadingState extends AuthStates {}

class AuthErrorState extends AuthStates {
  final String message;

  AuthErrorState(this.message);
}

class AuthSuccessState extends AuthStates {
  final Account account;

  AuthSuccessState(this.account);
}
