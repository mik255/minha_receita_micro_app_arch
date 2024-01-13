import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/models/account.dart';
import '../../../common/models/credentials.dart';
import '../auth_repository.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  Account account;

  AuthSuccess(this.account);
}

class AuthCubit extends Cubit<AuthState> {
  AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<void> auth(Credentials credentials) async {
    emit(AuthLoading());
    var account = await authRepository.auth(credentials);
    emit(AuthSuccess(account));
  }
}
