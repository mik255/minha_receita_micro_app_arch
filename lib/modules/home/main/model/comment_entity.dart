class CommentEntity {
  final int id;
  final String comment;
  final String createdAt;
  final String updatedAt;
  final int userId;
  final int postId;

  CommentEntity({
    required this.id,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.postId,
  });

  factory CommentEntity.fromJson(Map<String, dynamic> json) => CommentEntity(
        id: json["id"],
        comment: json["comment"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        userId: json["user_id"],
        postId: json["post_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user_id": userId,
        "post_id": postId,
      };
}
