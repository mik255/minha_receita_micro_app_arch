import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/dto/register_dto.dart';
import '../../data/repository/account_repository.dart';
import '../states/register_states.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final IAccountRepository accountRepository;

  RegisterCubit(this.accountRepository)
      : super(
          RegisterInitial(),
        );

  Future<void> requestRegister(
    UserInfoRequestDTO request,
  ) async {
    emit(RegisterLoading());
    try {
      await accountRepository.sendUserInfo(request);
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
