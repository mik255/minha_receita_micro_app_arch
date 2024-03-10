class MethodOfPreparation {
  MethodOfPreparation({
    required this.step,
    required this.description,
  });

  num step;
  String description;


  factory MethodOfPreparation.fromJson(Map<String, dynamic> json) =>
      MethodOfPreparation(
        step: json['step'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'step': step,
        'description': description,
      };
}
