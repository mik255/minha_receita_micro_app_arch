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
}
