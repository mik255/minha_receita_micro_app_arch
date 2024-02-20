
class EmailState{}

class EmailEmpty extends EmailState {}
class EmailValid extends EmailState {}
class EmailInvalid extends EmailState {
  final String message;
  EmailInvalid(this.message);
}