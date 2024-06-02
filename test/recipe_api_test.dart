import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:receptai/api/recipe_api.dart';
import 'package:test/test.dart';

import 'recipe_api_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  group('RecipeApi', () {
    final mockDio = MockDio();
    final recipeApi = RecipeApi();

    test('generateRecipe returns expected response', () async {
      when(mockDio.post(any, data: anyNamed('data'), options: anyNamed('options'))).thenAnswer(
          (_) async => Response(data: 'response', statusCode: 200, requestOptions: RequestOptions(path: '')));
      final response = await recipeApi.generateRecipe([1, 2, 3]);
      expect(response.data, 'response');
    });

    test('addRecipeToFavourite returns expected response', () async {
      when(mockDio.post(any)).thenAnswer(
          (_) async => Response(data: 'response', statusCode: 200, requestOptions: RequestOptions(path: '')));
      final response = await recipeApi.addRecipeToFavourite(1, 2);
      expect(response.data, 'response');
    });

    test('getAllFavouriteRecipes returns expected response', () async {
      when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
          (_) async => Response(data: 'response', statusCode: 200, requestOptions: RequestOptions(path: '')));
      final response = await recipeApi.getAllFavouriteRecipes(1);
      expect(response.data, 'response');
    });

    test('deleteFavouriteRecipe returns expected response', () async {
      when(mockDio.delete(any)).thenAnswer(
          (_) async => Response(data: 'response', statusCode: 200, requestOptions: RequestOptions(path: '')));
      final response = await recipeApi.deleteFavouriteRecipe(1);
      expect(response.data, 'response');
    });

    test('getIngredients returns expected response', () async {
      when(mockDio.get(any)).thenAnswer(
          (_) async => Response(data: 'response', statusCode: 200, requestOptions: RequestOptions(path: '')));
      final response = await recipeApi.getIngredients(1);
      expect(response.data, 'response');
    });
  });
}
