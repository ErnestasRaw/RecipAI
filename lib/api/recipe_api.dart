import 'package:dio/dio.dart';
import 'package:receptai/helpers/logger_helper.dart';

final dio = Dio();

class RecipeApi {
  Future<Response> generateRecipe(List<int> ingredientIds) async {
    try {
      final response = await dio.post(
        'https://10.0.2.2:7012/Recipe/GenerateRecipe',
        data: ingredientIds,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> addRecipeToFavourite(int userId, int recipeId) async {
    try {
      final response = await dio.post(
        'https://10.0.2.2:7012/Recipe/AddRecipeToFavourite/$userId/$recipeId',
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getAllFavouriteRecipes(int userId) async {
    xlog('userId: $userId');
    try {
      final response = await dio.get(
        'https://10.0.2.2:7012/Recipe/GetAllFavouriteRecipes/$userId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      xlog('returning response: ${response.data}');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteFavouriteRecipe(int recipeId) async {
    try {
      final response = await dio.delete(
        'https://10.0.2.2:7012/Recipe/DeleteFavouriteRecipe/$recipeId',
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getIngredients(int? categoryId) async {
    try {
      final response = await dio.get(
        'https://10.0.2.2:7012/Recipe/GetIngredients/$categoryId',
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
