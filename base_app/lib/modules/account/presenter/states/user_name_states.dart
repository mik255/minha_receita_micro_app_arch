
class UserNameStates {}

class UserNameIsEmpty extends UserNameStates {}

class UserNameValid extends UserNameStates {}

class UserNameNotValid extends UserNameStates {
  final String message;
  UserNameNotValid(this.message);
}