class CommentEntity {
  final String id;
  final String userId;
  final String comment;
  final String createdAt;
  final String urlImg;
  final String name;

  CommentEntity({
    required this.id,
    required this.comment,
    required this.createdAt,
    required this.userId,
    required this.urlImg,
    required this.name,
  });

  factory CommentEntity.fromJson(Map<String, dynamic> json) => CommentEntity(
        id: json['id'],
        comment: json['comment'],
        createdAt: json['createdAt'],
        userId: json['userId'],
        urlImg: json['urlImg'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "createdAt": createdAt,
        "userId": userId,
        "urlImg": urlImg,
        "name": name,
      };
}
