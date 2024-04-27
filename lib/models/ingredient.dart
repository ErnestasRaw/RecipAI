import 'package:receptai/models/category_enum.dart';

class Ingredient {
  int ingredientId;
  String name;
  ProductCategory category;

  Ingredient({
    required this.ingredientId,
    required this.name,
    required this.category,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      ingredientId: json['ingredientId'],
      name: json['name'],
      category: ProductCategory.fromId(json['categoryId']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['ingredientId'] = ingredientId;
    data['name'] = name;
    data['categoryId'] = category.index;
    return data;
  }
}
