import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:receptai/api/recipe_api.dart';
import 'package:receptai/models/category_enum.dart';
import 'package:receptai/views/app/pages/controllers/generator_controller.dart';
import 'package:test/test.dart';

class MockRecipeApi extends Mock implements RecipeApi {
  @override
  Future<Response> getIngredients(int? categoryId) async {
    return Response(data: {'data': []}, statusCode: 200, requestOptions: RequestOptions());
  }
}

class MockGeneratorController extends Mock implements GeneratorController {
  @override
  Future<void> fetchIngredients() async {
    fetchedIngredients = [];
  }

  @override
  void notifyListeners() {}

  @override
  void addIngredient(int ingredientId) {
    selectedIngredients.add(ingredientId);
  }

  @override
  void removeIngredient(int ingredientId) {
    selectedIngredients.remove(ingredientId);
  }

  @override
  Future<void> onCategoryChanged(ProductCategory value) async {
    selectedCategory = value;
    await fetchIngredients();
  }

  @override
  void dispose() {}
}

void main() {
  group('GeneratorController', () {
    late GeneratorController generatorController;
    late MockRecipeApi mockRecipeApi;

    setUp(() {
      mockRecipeApi = MockRecipeApi();
      generatorController = GeneratorController(recipeApi: mockRecipeApi);
    });
    //
    // test('fetches ingredients when category changes', () async {
    //   when(mockRecipeApi.getIngredients(any))
    //       .thenAnswer((_) async => Response(data: {'data': []}, statusCode: 200, requestOptions: RequestOptions()));
    //
    //   await generatorController.onCategoryChanged(ProductCategory.meatAndPoultry);
    //
    //   verify(mockRecipeApi.getIngredients(ProductCategory.meatAndPoultry.id)).called(1);
    //   expect(generatorController.fetchedIngredients, isEmpty);
    // });
    //
    // test('updates selected category when category changes', () async {
    //   await generatorController.onCategoryChanged(ProductCategory.meatAndPoultry);
    //
    //   expect(generatorController.selectedCategory, equals(ProductCategory.meatAndPoultry));
    // });

    test('adds ingredient to selected ingredients', () {
      generatorController.addIngredient(1);

      expect(generatorController.selectedIngredients, contains(1));
    });

    test('removes ingredient from selected ingredients', () {
      generatorController.addIngredient(1);
      generatorController.removeIngredient(1);

      expect(generatorController.selectedIngredients, isNot(contains(1)));
    });
  });
}
