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
        id: json["_id"]??'',
        comment: json['value']["comment"],
        createdAt: json['value']["createdAt"],
        updatedAt: '',
        userId: json['user']["_id"],
        postId: json['value']["postId"],
        urlImg: json['user']?["avatarUrl"]??'https://i.stack.imgur.com/l60Hf.png',
        name: json['user']["nome"],
        replyChildrenId: '',
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
