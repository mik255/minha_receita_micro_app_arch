import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minha_receita/common/models/account.dart';
import 'package:minha_receita/common/models/credentials.dart';
import '../../data/repository/account_repository.dart';
import '../states/auth_states.dart';

class AccountCubit extends Cubit<AuthStates> {
  AccountCubit(
    this.accountRepository,
  ) : super(AuthInitialState());

  Account? account;
  final IAccountRepository accountRepository;

  void auth(Credentials credentials) async {
    emit(AuthLoadingState());
    try {
      account = await accountRepository.auth(credentials);
      emit(AuthSuccessState(account!));
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }
}
