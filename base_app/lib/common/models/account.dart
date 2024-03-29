import 'package:minha_receita/common/models/user/domain/models/user.dart';

class Account {
  final UserModel user;
  final String token;

  Account({
    required this.user,
    required this.token,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        user: UserModel.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
      };

  @override
  String toString() {
    return 'Account{user: $user, token: $token}';
  }
}
