import '../../micro_app_common.dart';

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
}
