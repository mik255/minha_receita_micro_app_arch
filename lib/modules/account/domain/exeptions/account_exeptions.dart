class DomainAccountException implements Exception {
  final String message = "Erro ao realizar login";
}

class EmailInvalidException implements DomainAccountException {
  @override
  final String message = "Email inválido";
}

class EmptyFieldException implements DomainAccountException {
  @override
  final String message = "Campo obrigatório";
}

class PasswordInvalidException implements DomainAccountException {
  @override
  final String message = "Senha inválida";
}

class EmailAlreadyInUseException implements DomainAccountException {
  @override
  final String message = "Email já cadastrado";
}

class UserNotFoundException implements DomainAccountException {
  @override
  final String message = "Usuário não encontrado";
}

class InvalidCredentialsException implements DomainAccountException {
  @override
  final String message = "Credenciais inválidas";
}

class UnexpectedException implements DomainAccountException {
  @override
  final String message = "Erro inesperado";
}

class CredentialsAtLeast6Characters implements DomainAccountException {
  @override
  final String message = "Devem ter pelo menos 6 caracteres";
}

class CredentialsAtLeast1Number implements DomainAccountException {
  @override
  final String message = "Devem ter pelo menos 1 número";
}

class CredentialsAtLeast1SpecialCharacter implements DomainAccountException {
  @override
  final String message = "Devem ter pelo menos 1 caractere especial";
}

class CredentialsAtLeast1Uppercase implements DomainAccountException {
  @override
  final String message = "Devem ter pelo menos 1 letra maiúscula";
}

class CredentialsAtLeast1Lowercase implements DomainAccountException {
  @override
  final String message = "Devem ter pelo menos 1 letra minúscula";
}
