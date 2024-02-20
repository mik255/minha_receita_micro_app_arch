class PasswordState{}

class PasswordEmpty extends PasswordState {}
class PasswordValid extends PasswordState {}

class PasswordInvalid extends PasswordState {
  final String message;
  PasswordInvalid(this.message);
}