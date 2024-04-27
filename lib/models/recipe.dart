class Recipe {
  int recipeId;
  String name;
  String instructions;
  String ingredients;

  Recipe({
    required this.recipeId,
    required this.name,
    required this.instructions,
    required this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        recipeId: json['recipeId'],
        name: json['name'],
        instructions: json['instructions'],
        ingredients: json['ingredients'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['recipeId'] = recipeId;
    data['name'] = name;
    data['instructions'] = instructions;
    data['ingredients'] = ingredients;

    return data;
  }
}
