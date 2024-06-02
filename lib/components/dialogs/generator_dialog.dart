import 'package:flutter/material.dart';
import 'package:receptai/api/recipe_api.dart';
import 'package:receptai/components/theme/palette.dart';
import 'package:receptai/components/theme/styles.dart';
import 'package:receptai/controllers/user_controller.dart';
import 'package:receptai/models/recipe.dart';

class GeneratorDialog {
  static Future<void> show(
    BuildContext context, {
    required Recipe recipe,
    Future Function()? onRegenerate,
    bool isFavorite = false,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(recipe.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                recipe.ingredients.toString(),
                style: Styles.ag16Medium(),
              ),
              SizedBox(
                height: 160,
                child: SingleChildScrollView(
                  child: Text(recipe.instructions),
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            StatefulBuilder(
              builder: (context, setState) {
                return IconButton(
                  onPressed: () async {
                    if (isFavorite == false) {
                      await RecipeApi().addRecipeToFavourite(
                        UserController().loggedInUser!.userId,
                        recipe.recipeId,
                      );
                      isFavorite = !isFavorite;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Receptas jau yra įtrauktas į mėgstamiausių sąrašą.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                    setState(() {});
                  },
                  icon: Icon(
                    !isFavorite ? Icons.favorite_border : Icons.favorite,
                    color: !isFavorite ? Palette.grey : Palette.seedColor,
                  ),
                );
              },
            ),
            if (onRegenerate != null)
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () async {
                  await onRegenerate();
                },
              ),
            FilledButton(
              child: const Text('Atgal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
