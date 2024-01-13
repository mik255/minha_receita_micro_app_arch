import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:minha_receita/common/extensions/string.dart';

import '../../../../common/models/account.dart';
import '../../../auth/cubit/auth_cubit.dart';
import '../states/login_states.dart';

class LoginStore extends ChangeNotifier {
  Account? account;
  String email = '';
  String password = '';
  bool buttonEnabled = false;
  LoginState state = LoginInitial();
  StreamSubscription? _subscription;

  void setEmail(String value) {
    email = value;
    emailIsValid();
  }

  void setPassword(String value) {
    password = value;
    passwordIsValid();
  }

  String? emailIsValid() {
    try {
      email.emailValidate();
      buttonIsEnabled();
      return null;
    } catch (e) {
      buttonEnabled = false;
      return e.toString();
    }
  }

  String? passwordIsValid() {
    try {
      password.passwordValidate();
      buttonIsEnabled();
      return null;
    } catch (e) {
      buttonEnabled = false;
      return e.toString();
    }
  }

  buttonIsEnabled() {
    try {
      email.emailValidate();
      password.passwordValidate();
      buttonEnabled = true;
    } catch (e) {
      buttonEnabled = false;
    }
    Future.delayed(const Duration(milliseconds: 100))
        .then((value) => notifyListeners());
  }

  void loginEvent(AuthState authState) async {
    try {
      if (authState is AuthLoading) {
        state = LoginLoading();
        notifyListeners();
        return;
      } else if (authState is AuthSuccess) {
        account = authState.account;
        state = LoginSuccess();
        notifyListeners();
        return;
      }
      state = LoginError('Erro ao realizar login');
      notifyListeners();
    } catch (e) {
      state = LoginError(e.toString());
      notifyListeners();
    }
  }

  close() {
    _subscription?.cancel();
  }
}
