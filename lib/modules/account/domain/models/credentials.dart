import '../exeptions/account_exeptions.dart';

class Credentials {
  String email;
  String password;

  Credentials({
    required this.email,
    required this.password,
  });

  factory Credentials.fromJson(Map<String, dynamic> json) => Credentials(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };

  void emailValidate() {
    if (email.isEmpty) {
      throw EmptyFieldException();
    }
    var emailRegex = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegex.hasMatch(email)) {
      throw EmailInvalidException();
    }
  }

  void passwordValidate() {
    if (password.isEmpty) {
      throw EmptyFieldException();
    }
    RegExp lowercaseRegex = RegExp(r'(?=.*[a-z])');
    RegExp uppercaseRegex = RegExp(r'(?=.*[A-Z])');
    RegExp digitRegex = RegExp(r'(?=.*\d)');
    RegExp specialCharRegex = RegExp(r'(?=.*[@#$%^&+=])');
    RegExp lengthRegex = RegExp(r'(?=.{6,})');

    if (!lowercaseRegex.hasMatch(password)) {
      throw CredentialsAtLeast1Lowercase();
    }
    if (!uppercaseRegex.hasMatch(password)) {
      throw CredentialsAtLeast1Uppercase();
    }
    if (!digitRegex.hasMatch(password)) {
      throw CredentialsAtLeast1Number();
    }
    if (!specialCharRegex.hasMatch(password)) {
      throw CredentialsAtLeast1SpecialCharacter();
    }
    if (!lengthRegex.hasMatch(password)) {
      throw CredentialsAtLeast6Characters();
    }
  }
}
