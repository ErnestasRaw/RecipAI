import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:receptai/api/recipe_api.dart';
import 'package:receptai/models/category_enum.dart';
import 'package:receptai/models/ingredient.dart';

class GeneratorController extends ChangeNotifier {
  final RecipeApi recipeApi;
  GeneratorController({RecipeApi? recipeApi}) : recipeApi = recipeApi ?? RecipeApi();

  ProductCategory _selectedCategory = ProductCategory.values.last;
  ProductCategory get selectedCategory => _selectedCategory;

  List<Ingredient> fetchedIngredients = [];
  List<int> selectedIngredients = [];

  Future<void> fetchIngredients() async {
    Response response = await RecipeApi().getIngredients(_selectedCategory.id);
    fetchedIngredients =
        (response.data['data']).map<Ingredient>((ingredient) => Ingredient.fromJson(ingredient)).toList();
    notifyListeners();
  }

  void addIngredient(int ingredientId) {
    selectedIngredients.add(ingredientId);
    notifyListeners();
  }

  void removeIngredient(int ingredientId) {
    selectedIngredients.remove(ingredientId);
    notifyListeners();
  }

  Future<void> onCategoryChanged(ProductCategory value) async {
    _selectedCategory = value;
    await fetchIngredients();
  }
}
