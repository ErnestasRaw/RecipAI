class Recipe {
  int recipeId;
  String name;
  String instructions;
  List<String>? ingredients;

  Recipe({
    required this.recipeId,
    required this.name,
    required this.instructions,
    this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        recipeId: json['recipeId'],
        name: json['name'],
        instructions: json['instructions'],
        ingredients: json['ingredients'] != null ? List<String>.from(json['ingredients'].map((x) => x)) : null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['recipeId'] = recipeId;
    data['name'] = name;
    data['instructions'] = instructions;
    if (ingredients != null) {
      data['ingredients'] = ingredients!.map((x) => x).toList();
    }
    return data;
  }
}
