class Ingredient {
  Ingredient({required this.description});

  String description;

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'description': description,
      };
}
