import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/models/account.dart';
import '../../data/repository/account_repository.dart';
import '../states/code_confirmation_states.dart';

class CodeConfirmationCubit extends Cubit<CodeConfirmationStates> {
  final IAccountRepository accountRepository;

  BehaviorSubject timeToResend = BehaviorSubject<int>.seeded(0);
  CodeConfirmationCubit(this.accountRepository)
      : super(
          CodeConfirmationLoadingState(),
        );

  Future<void> sendRequest(String email) async {
    emit(CodeConfirmationLoadingState());
    try {
      countDown();
      await accountRepository.sendRequestCode(email);
      emit(SendCodeConfirmationSuccess());
    } catch (e) {
      emit(CodeConfirmationErrorState(e.toString()));
    }
  }

  Future<Account> validateCode(
    String code,
  ) async {
    emit(CodeConfirmationLoadingState());
    try {
      if(code.isEmpty){
        throw 'Código não pode ser vazio';
      }
      if(code.length < 4){
        throw 'Código deve ter no mínimo 4 caracteres';
      }

      final account = await accountRepository.confirmRequestCode(code);
      emit(CodeConfirmationSuccessState(account));
      return account;
    } catch (e) {
      emit(CodeConfirmationErrorState(e.toString()));
      rethrow;
    }
  }
  void countDown()async{
    timeToResend.add(10);
    for (var i = timeToResend.value; i >= 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      timeToResend.add(i);
    }
  }
}
