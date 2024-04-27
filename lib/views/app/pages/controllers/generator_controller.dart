import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:receptai/models/category_enum.dart';
import 'package:receptai/models/ingredient.dart';

import '../../../../api/recipe_api.dart';

class GeneratorController extends ChangeNotifier {
  GeneratorController();

  ProductCategory _selectedCategory = ProductCategory.values.last;
  ProductCategory get selectedCategory => _selectedCategory;

  List<Ingredient> fetchedIngredients = [];
  List<int> selectedIngredients = [];

  Future<void> fetchIngredients() async {
    Response response = await RecipeApi.getIngredients(_selectedCategory.id);
    fetchedIngredients =
        (response.data['data']).map<Ingredient>((ingredient) => Ingredient.fromJson(ingredient)).toList();
    notifyListeners();
  }

  Future<void> onCategoryChanged(ProductCategory value) async {
    _selectedCategory = value;
    await fetchIngredients();
  }
}
