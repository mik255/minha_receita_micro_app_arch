import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../../common/user/domain/models/user.dart';
import '../../domain/exeptions/account_exeptions.dart';
import '../../domain/models/credentials.dart';
import '../../domain/usecases/register_usecase.dart';
import '../states/register_states.dart';

class RegisterStore extends ChangeNotifier {
  var credentials = Credentials(
    email: '',
    password: '',
  );
  bool buttonEnabled = false;
  RegisterState state = RegisterInitial();
  final RegisterUseCase _registerUseCase;

  RegisterStore(RegisterUseCase registerUseCase)
      : _registerUseCase = registerUseCase;

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

  void registerEvent() async {
    try {
      state = RegisterLoading();
      notifyListeners();
      var account = await _registerUseCase(credentials);
      GetIt.I<UserModel>().setUser(account.user);
      state = RegisterSuccess();
      notifyListeners();
    } catch (e, _) {
      if (kDebugMode) {
        print(e);
        print(_);
      }

      state = RegisterError(e.toString());
      notifyListeners();
    }
  }

  void sendVerificationEvent() async {
    try {
      state = RegisterLoading();
      notifyListeners();
      await _registerUseCase(credentials);
      state = RegisterSuccess();
      notifyListeners();
    } catch (e, _) {
      if (kDebugMode) {
        print(e);
        print(_);
      }

      state = RegisterError(e.toString());
      notifyListeners();
    }
  }

  void verificationCodeEvent() async {
    try {
      state = RegisterLoading();
      notifyListeners();
      await _registerUseCase(credentials);
      registerEvent();
      notifyListeners();
    } catch (e, _) {
      if (kDebugMode) {
        print(e);
        print(_);
      }

      state = RegisterError(e.toString());
      notifyListeners();
    }
  }
}
