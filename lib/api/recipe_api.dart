import 'package:dio/dio.dart';
import 'package:receptai/globals.dart';
import 'package:receptai/helpers/logger_helper.dart';

final dio = Dio();

class RecipeApi {
  static Future<Response> generateRecipe(List<int> ingredientIds) async {
    try {
      final response = await dio.post(
        'https://$baseUrl/Recipe/GenerateRecipe',
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

  static Future<Response> addRecipeToFavourite(int userId, int recipeId) async {
    try {
      final response = await dio.post(
        'https://$baseUrl/Recipe/AddRecipeToFavourite/$userId/$recipeId',
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> getAllFavouriteRecipes(int userId) async {
    xlog('userId: $userId');
    try {
      final response = await dio.get(
        'https://$baseUrl/Recipe/GetAllFavouriteRecipes/$userId',
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

  static Future<Response> deleteFavouriteRecipe(int recipeId) async {
    try {
      final response = await dio.delete(
        'https://$baseUrl/Recipe/DeleteFavouriteRecipe/$recipeId',
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> getIngredients(int categoryId) async {
    try {
      final response = await dio.get(
        'https://$baseUrl/Recipe/GetIngredients/$categoryId',
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
