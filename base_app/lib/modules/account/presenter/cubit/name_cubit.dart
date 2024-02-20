import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/user_name_states.dart';

class UserNameCubit extends Cubit<UserNameStates> {
  UserNameCubit() : super(UserNameIsEmpty());
  String userName = '';
  void setName(String value) {
    userName = value;
    try {
      var nameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
      if(value.length < 3){
        throw 'Nome deve ter no mínimo 3 caracteres';
      }
      if (!nameRegex.hasMatch(value)) {
        throw 'Nome deve conter apenas letras, números e _';
      }
      emit(UserNameValid());
    } catch (e) {
      emit(UserNameNotValid(
        e.toString(),
      ));
    }
  }
}
