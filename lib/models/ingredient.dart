import 'package:receptai/models/category_enum.dart';

class Ingredient {
  int ingredientId;
  String name;
  String quantity;
  String unit;
  ProductCategory category;

  Ingredient({
    required this.ingredientId,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.category,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        ingredientId: json['ingredientId'],
        name: json['name'],
        quantity: json['quantity'],
        unit: json['unit'],
        category: ProductCategory.values[json['category']],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['ingredientId'] = ingredientId;
    data['name'] = name;
    data['quantity'] = quantity;
    data['unit'] = unit;
    data['category'] = category.index;
    return data;
  }
}
