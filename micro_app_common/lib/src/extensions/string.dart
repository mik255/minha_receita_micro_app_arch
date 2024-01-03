import 'package:micro_app_common/src/exceptions/account_exeptions.dart';

extension ConvertToDate on String {
  DateTime coreExtensionsConvertToDate() {
    var date = DateTime.parse(this);
    return date;
  }
  void emailValidate() {
    if (isEmpty) {
      throw EmptyFieldException();
    }
    var emailRegex = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegex.hasMatch(this)) {
      throw EmailInvalidException();
    }
  }

  void passwordValidate() {
    if (isEmpty) {
      throw EmptyFieldException();
    }
    RegExp lowercaseRegex = RegExp(r'(?=.*[a-z])');
    RegExp uppercaseRegex = RegExp(r'(?=.*[A-Z])');
    RegExp digitRegex = RegExp(r'(?=.*\d)');
    RegExp specialCharRegex = RegExp(r'(?=.*[@#$%^&+=])');
    RegExp lengthRegex = RegExp(r'(?=.{6,})');

    if (!lowercaseRegex.hasMatch(this)) {
      throw CredentialsAtLeast1Lowercase();
    }
    if (!uppercaseRegex.hasMatch(this)) {
      throw CredentialsAtLeast1Uppercase();
    }
    if (!digitRegex.hasMatch(this)) {
      throw CredentialsAtLeast1Number();
    }
    if (!specialCharRegex.hasMatch(this)) {
      throw CredentialsAtLeast1SpecialCharacter();
    }
    if (!lengthRegex.hasMatch(this)) {
      throw CredentialsAtLeast6Characters();
    }
  }

}
