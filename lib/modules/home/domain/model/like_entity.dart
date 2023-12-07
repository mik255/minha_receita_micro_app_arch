class LikeEntity {
  LikeEntity({
    required this.urlImg,
    required this.name,
    required this.description,
    required this.isFallowing,
  });

  String urlImg;
  String name;
  String description;
  bool isFallowing;

  factory LikeEntity.fromJson(Map<String, dynamic> json) => LikeEntity(
        urlImg: json["urlImg"],
        name: json["name"],
        description: json["description"],
        isFallowing: json["isFallowing"],
      );

  Map<String, dynamic> toJson() => {
        "urlImg": urlImg,
        "name": name,
        "description": description,
        "isFallowing": isFallowing,
      };
}