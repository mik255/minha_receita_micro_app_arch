import '../../../../common/models/account.dart';

class CodeConfirmationStates {}

class CodeConfirmationInitState extends CodeConfirmationStates {}

class CodeConfirmationLoadingState extends CodeConfirmationStates {}

class CodeConfirmationSuccessState extends CodeConfirmationStates {
  final Account account;

  CodeConfirmationSuccessState(this.account);
}

class SendCodeConfirmationSuccess extends CodeConfirmationStates {}

class CodeConfirmationErrorState extends CodeConfirmationStates {
  final String message;

  CodeConfirmationErrorState(this.message);
}

class CodeConfirmationResendState extends CodeConfirmationStates {}
