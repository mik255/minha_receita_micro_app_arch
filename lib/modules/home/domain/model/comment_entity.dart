class CommentEntity {
  final String id;
  final String replyChildrenId;
  final String userId;
  final String postId;
  final String comment;
  final String createdAt;
  final String updatedAt;
  final String urlImg;
  final String name;
  final List<CommentEntity> replyChildren;

  CommentEntity({
    required this.id,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.postId,
    required this.urlImg,
    required this.name,
    required this.replyChildrenId,
    this.replyChildren = const [],
  });

  factory CommentEntity.fromJson(Map<String, dynamic> json) => CommentEntity(
        id: json["id"],
        comment: json["comment"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        userId: json["userId"],
        postId: json["postId"],
        urlImg: json["urlImg"],
        name: json["name"],
        replyChildrenId: json["replyChildrenId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "urlImg": urlImg,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "userId": userId,
        "postId": postId,
        "name": name,
        "replyChildrenId": replyChildrenId,
      };
}
