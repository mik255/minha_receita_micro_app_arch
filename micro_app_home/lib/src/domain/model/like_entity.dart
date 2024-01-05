class LikeEntity {
  LikeEntity({
    required this.id,
    required this.urlImg,
    required this.name,
    required this.description,
    required this.isFallowing,
    required this.autorUserId,
  });
  String id;
  String? urlImg;
  String name;
  String description;
  bool isFallowing;
  String autorUserId;

  factory LikeEntity.fromJson(Map<String, dynamic> json) => LikeEntity(
        id: json["id"],
        urlImg: json["avatarUrl"],
        name: json["userName"],
        description: json["description"]??'Sem descrição',
        isFallowing: json["userIsFollowing"],
        autorUserId: json["autorUserId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "urlImg": urlImg,
        "name": name,
        "description": description,
        "isFallowing": isFallowing,
        "autorUserId": autorUserId,
      };
}
