import 'package:flutter/foundation.dart';
import 'package:micro_app_common/micro_app_common.dart';
import 'package:micro_app_core/micro_app_core.dart';
import '../states/login_states.dart';

class LoginStore extends ChangeNotifier {
  Account? account;
  final EventBusService _eventBusService;
  String email = '';
  String password = '';
  bool buttonEnabled = false;
  LoginState state = LoginInitial();

  LoginStore(EventBusService eventBusService)
      : _eventBusService = eventBusService;

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

  void loginEvent() async {
    try {
      state = LoginLoading();
      notifyListeners();
      _eventBusService.emit<AuthEvent>(
        AuthEvent(
          Credentials(
            email: email,
            password: password,
          ),
        ),
      );
      _eventBusService.on<AuthenticatedEvent>((
        event,
      ) async {
        account = event.account;
        state = LoginInitial();
        buttonEnabled = true;
        notifyListeners();
        _eventBusService.emit(
          GetAccountEvent(account!),
        );
        _eventBusService.emit<AccountAuthenticatedEvent>(
          AccountAuthenticatedEvent(),
        );
      });
    } catch (e) {
      state = LoginError(e.toString());
      notifyListeners();
    }
  }
}
