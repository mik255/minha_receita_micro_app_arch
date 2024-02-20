import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minha_receita/common/extensions/string.dart';
import '../states/email_states.dart';

class EmailCubit extends Cubit<EmailState> {
  EmailCubit() : super(EmailEmpty());
  String email = '';
  void setEmail(String value) {
    email = value;
    try {
      value.emailValidate();
      emit(EmailValid());
    } catch (e) {
      emit(EmailInvalid(
        e.toString(),
      ));
    }
  }
}

