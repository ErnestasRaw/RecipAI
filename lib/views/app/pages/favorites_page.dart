import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:receptai/api/recipe_api.dart';
import 'package:receptai/components/dialogs/generator_dialog.dart';
import 'package:receptai/components/theme/palette.dart';
import 'package:receptai/components/theme/styles.dart';
import 'package:receptai/controllers/user_controller.dart';
import 'package:receptai/helpers/logger_helper.dart';
import 'package:receptai/models/recipe.dart';
import 'package:receptai/views/app/pages/home_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  Future<List<Recipe?>> fetchFavorites() async {
    Response response = await RecipeApi().getAllFavouriteRecipes(UserController().loggedInUser!.userId);

    if (response.data['data'] == null) {
      return [];
    }
    try {
      List<Recipe?> recipes = (response.data['data']).map<Recipe>((recipe) => Recipe.fromJson(recipe)).toList();
      return recipes;
    } catch (e) {
      xlog('Error: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<Recipe?>>(
        future: fetchFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Įvyko klaida'));
          }
          if (snapshot.connectionState == ConnectionState.none) {
            return const Center(child: Text('Nėra prisijungta prie interneto'));
          }
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text('Nėra mėgstamų receptų'));
          }
          return ListView(
            children: snapshot.data!.map((recipe) => _buildRecipeCard(recipe, context)).toList(),
          );
        },
      ),
    );
  }

  Widget _buildRecipeCard(Recipe? recipe, BuildContext context) {
    if (recipe == null) return const SizedBox();

    return Card(
      child: InkWell(
        child: StyledCard(
          child: Row(
            children: [
              Expanded(
                flex: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.name,
                      style: Styles.titleAg25Semi(color: Colors.black),
                    ),
                    Text(
                      recipe.ingredients,
                      style: Styles.ag16Medium(color: Palette.seedColor),
                    ),
                  ],
                ),
              ),
              Expanded(flex: 10, child: Icon(Icons.arrow_forward_ios_sharp)),
            ],
          ),
        ),
        onTap: () {
          GeneratorDialog.show(context, recipe: recipe, isFavorite: true);
        },
      ),
    );
  }
}
