class UserStore {
  String userId;
  String userImgUrl;
  StorePost post;

  UserStore(
      {required this.userId, required this.userImgUrl, required this.post});

  factory UserStore.fromJson(Map<String, dynamic> json) {
    return UserStore(
      userId: json['userId'] ?? "",
      userImgUrl: json['userImgUrl'] ?? "",
      post: StorePost.fromJson(json['post'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userImgUrl': userImgUrl,
      'post': post.toJson(),
    };
  }
}

class StorePost {
  String imgUrl;
  String description;

  StorePost({required this.imgUrl, required this.description});

  factory StorePost.fromJson(Map<String, dynamic> json) {
    return StorePost(
      imgUrl: json['imgUrl'] ?? "",
      description: json['description'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imgUrl': imgUrl,
      'description': description,
    };
  }
}
