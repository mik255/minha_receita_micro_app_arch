class HomeUserModel {
  final String name;
  final String email;
  final String photoUrl;

  HomeUserModel({
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  factory HomeUserModel.fromJson(Map<String, dynamic> json) => HomeUserModel(
        name: json['name'],
        email: json['email'],
        photoUrl: json['photoUrl'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "photoUrl": photoUrl,
      };
}
