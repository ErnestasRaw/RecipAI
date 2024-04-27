// Import the required libraries
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:receptai/api/recipe_api.dart';
import 'package:receptai/models/category_enum.dart';
import 'package:receptai/views/app/pages/controllers/generator_controller.dart';
import 'package:test/test.dart';

// Mock RecipeApi for testing
class MockRecipeApi extends Mock implements RecipeApi {
  RecipeApi recipeApi = RecipeApi();

  @override
  Future<Response> getIngredients(int categoryId) async {
    return Response(
      data: {
        "data": [
          {"ingredientId": 1, "name": "Rice", "categoryId": 1},
          {"ingredientId": 2, "name": "Wheat", "categoryId": 1},
          {"ingredientId": 3, "name": "Oats", "categoryId": 1},
          {"ingredientId": 4, "name": "Barley", "categoryId": 1},
          {"ingredientId": 5, "name": "Quinoa", "categoryId": 1}
        ],
        "success": true
      },
      statusCode: 200,
      requestOptions: RequestOptions(
        headers: {"Content-Type": "application/json"},
      ),
    );
  }

  // @override
  // Future<Response> generateRecipe(List<int> ingredientIds) async {
  //   return
  // }
}

void main() {
  // Group tests for GeneratorController
  group('GeneratorController Tests', () {
    // Test initial state
    test('initial state - selectedCategory and fetchedIngredients', () {
      final controller = GeneratorController();
      expect(controller.selectedCategory, ProductCategory.values.last);
      expect(controller.fetchedIngredients, []);
    });

    // Mock RecipeApi behavior
    final mockRecipeApi = MockRecipeApi();

    // Test fetchIngredients - success
    test('fetchIngredients - success', () async {
      // Mock successful response from RecipeApi
      final mockResponse = Response(
        data: {
          "data": [
            {"ingredientId": 1, "name": "Rice", "categoryId": 1},
            {"ingredientId": 2, "name": "Wheat", "categoryId": 1},
            {"ingredientId": 3, "name": "Oats", "categoryId": 1},
            {"ingredientId": 4, "name": "Barley", "categoryId": 1},
            {"ingredientId": 5, "name": "Quinoa", "categoryId": 1}
          ],
          "success": true
        },
        statusCode: 200,
        requestOptions: RequestOptions(
          headers: {"Content-Type": "application/json"},
        ),
      );
      when(mockRecipeApi.getIngredients(1)).thenAnswer((_) => Future.value(mockResponse));

      // Create controller and inject mocked RecipeApi (assuming dependency injection)
      final controller = GeneratorController(recipeApi: mockRecipeApi);

      // Call fetchIngredients and verify results
      await controller.fetchIngredients();
      expect(controller.fetchedIngredients.length, 1);
      expect(controller.fetchedIngredients[0].name, 'Rice');
    });

    // Test fetchIngredients - error (assuming throws error)
    test('fetchIngredients - error', () async {
      when(mockRecipeApi.getIngredients(1)).thenThrow(Exception('API Error'));
      final controller = GeneratorController(recipeApi: mockRecipeApi);

      // Expect error to be thrown
      expect(() => controller.fetchIngredients(), throwsException);
    });

    // Test onCategoryChanged - success
    test('onCategoryChanged - success', () async {
      // Create controller and inject mocked RecipeApi
      final controller = GeneratorController(recipeApi: mockRecipeApi);

      // Change category and verify fetchIngredients is called
      await controller.onCategoryChanged(ProductCategory.fruitsAndVegetables);
      verify(mockRecipeApi.getIngredients(ProductCategory.fruitsAndVegetables.id)).called(1);
    });
  });
}
