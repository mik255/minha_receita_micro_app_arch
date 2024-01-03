class PostModel {
  String userId;
  String description;
  String recipeId;

  PostModel({
    required this.userId,
    required this.description,
    required this.recipeId,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'recipeId': recipeId,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      userId: map['userId'],
      description: map['description'],
      recipeId: map['recipeId'],
    );
  }
}
