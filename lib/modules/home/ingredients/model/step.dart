class Step {
  Step({
    required this.step,
    required this.description,
  });

  final num step;
  String description;

  factory Step.fromJson(Map<String, dynamic> json) =>
      Step(
        step: json['step'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'step': step,
        'description': description,
      };
}
