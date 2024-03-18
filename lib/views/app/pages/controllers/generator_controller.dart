import 'package:receptai/models/category_enum.dart';
import 'package:receptai/models/ingredient.dart';

class GeneratorController {
  GeneratorController();

  ProductCategory selectedCategory = ProductCategory.values.last;

  List<Ingredient> get filteredIngredients =>
      exampleIngredients.where((element) => element.category == selectedCategory).toList();
  List<Ingredient> selectedIngredients = [];

  List<Ingredient> exampleIngredients = [
    Ingredient(
      ingredientId: 1,
      name: 'Morkos',
      quantity: '1',
      unit: 'vnt',
      category: ProductCategory.fruitsAndVegetables,
    ),
    Ingredient(
      ingredientId: 2,
      name: 'Bulvės',
      quantity: '2',
      unit: 'vnt',
      category: ProductCategory.fruitsAndVegetables,
    ),
    Ingredient(
      ingredientId: 3,
      name: 'Pomidorai',
      quantity: '3',
      unit: 'vnt',
      category: ProductCategory.fruitsAndVegetables,
    ),
    Ingredient(
      ingredientId: 5,
      name: 'Mėsa',
      quantity: '5',
      unit: 'vnt',
      category: ProductCategory.meatAndPoultry,
    ),
    Ingredient(
      ingredientId: 6,
      name: 'Pienas',
      quantity: '6',
      unit: 'vnt',
      category: ProductCategory.dairyProducts,
    ),
    Ingredient(
      ingredientId: 7,
      name: 'Kiauliena',
      quantity: '7',
      unit: 'vnt',
      category: ProductCategory.meatAndPoultry,
    ),
    Ingredient(
      ingredientId: 8,
      name: 'Vištiena',
      quantity: '8',
      unit: 'vnt',
      category: ProductCategory.meatAndPoultry,
    ),
    Ingredient(
      ingredientId: 9,
      name: 'Jogurtas',
      quantity: '9',
      unit: 'vnt',
      category: ProductCategory.dairyProducts,
    ),
    Ingredient(
      ingredientId: 10,
      name: 'Kefyras',
      quantity: '10',
      unit: 'vnt',
      category: ProductCategory.dairyProducts,
    ),
    Ingredient(
      ingredientId: 11,
      name: 'Kiaušiniai',
      quantity: '11',
      unit: 'vnt',
      category: ProductCategory.other,
    ),
  ];
}
