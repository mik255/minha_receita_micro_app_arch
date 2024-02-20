import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minha_receita/common/extensions/string.dart';

import '../states/password_states.dart';

class PasswordCubit extends Cubit<PasswordState> {
  PasswordCubit() : super(PasswordEmpty());

  String password = '';
  void setPassword(String value) {
    password = value;
    try {
      value.passwordValidate();
      emit(PasswordValid());
    } catch (e) {
      emit(PasswordInvalid(e.toString()));
    }
  }
}
