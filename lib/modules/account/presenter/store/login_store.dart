import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:minha_receita/modules/account/domain/models/credentials.dart';
import 'package:minha_receita/modules/account/domain/usecases/login_usecase.dart';

import '../../../../core/config/config.dart';
import '../../domain/exeptions/account_exeptions.dart';
import '../states/login_states.dart';

class LoginStore extends ChangeNotifier {
  final LoginUseCase _loginUseCase;
  var credentials = Credentials(
    email: '',
    password: '',
  );
  bool buttonEnabled = false;
  LoginState state = LoginInitial();

  LoginStore(LoginUseCase loginUseCase) : _loginUseCase = loginUseCase;

  void setEmail(String email) {
    credentials.email = email;
    emailIsValid();
  }

  void setPassword(String password) {
    credentials.password = password;
    passwordIsValid();
  }

  String? emailIsValid() {
    try {
      credentials.emailValidate();
      buttonIsEnabled();
      return null;
    } on DomainAccountException catch (e) {
      buttonEnabled = false;
      return e.message;
    }
  }

  String? passwordIsValid() {
    try {
      credentials.passwordValidate();
      buttonIsEnabled();
      return null;
    } on DomainAccountException catch (e) {
      buttonEnabled = false;
      return e.message;
    }
  }

  buttonIsEnabled() {
    try {
      credentials.emailValidate();
      credentials.passwordValidate();
      buttonEnabled = true;
    } catch (e) {
      buttonEnabled = false;
    }
    Future.delayed(const Duration(milliseconds: 100))
        .then((value) => notifyListeners());
  }

  void loginEvent() async {
    try {
      state = LoginLoading();
      notifyListeners();
      await _loginUseCase(credentials);
      navigateKey.currentState?.pushNamedAndRemoveUntil(
        '/home/main',
        (route) => false,
      );
      notifyListeners();
    } catch (e, _) {
      if (kDebugMode) {
        print(e);
        print(_);
      }

      state = LoginError(e.toString());
      notifyListeners();
    }
  }
}
