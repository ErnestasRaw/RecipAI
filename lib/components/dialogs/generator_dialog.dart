import 'dart:math';

import 'package:flutter/material.dart';
import 'package:receptai/components/theme/palette.dart';
import 'package:receptai/components/theme/styles.dart';
import 'package:receptai/models/recipe.dart';

class GeneratorDialog {
  static Future<void> show(BuildContext context, {bool? hasRegenrateButton = true}) async {
    bool isFavorite = false;

    List<Recipe> recipes = [
      Recipe(
        recipeId: 1,
        name: 'Morkų sriuba',
        ingredients: [
          'Morkos',
          'Bulvės',
          'Pomidorai',
        ],
        instructions:
            '1. Nulupkite morkas ir bulves. 2. Nuplaukite pomidorus. 3. Sudėkite visus ingredientus į puodą ir užpilkite vandeniu. 4. Virkite 30 minučių.',
      ),
      Recipe(
        recipeId: 2,
        name: 'Kepsnys',
        ingredients: [
          'Mėsa',
          'Pomidorai',
          'Bulvės',
        ],
        instructions:
            '1. Pjaustykite mėsą ir pomidorus. 2. Nulupkite bulves. 3. Sudėkite visus ingredientus į kepimo formą ir užpilkite aliejumi. 4. Kepkite 1 valandą.',
      ),
      Recipe(
        recipeId: 3,
        name: 'Kiaušiniai su pomidorais',
        ingredients: [
          'Kiaušiniai',
          'Pomidorai',
          'Pipirai',
        ],
        instructions:
            '1. Išplakite kiaušinius. 2. Pjaustykite pomidorus. 3. Sudėkite visus ingredientus į keptuvę ir kepkite 10 minučių.',
      ),
    ];

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        //pick randoom recipe
        Random random = Random();
        int randomIndex = random.nextInt(recipes.length);
        Recipe recipe = recipes[randomIndex];
        return AlertDialog(
          title: Text(recipe.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                recipe.ingredients.toString(),
                style: Styles.ag16Medium(),
              ),
              Text(recipe.instructions),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            StatefulBuilder(
              builder: (context, setState) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  icon: Icon(
                    !isFavorite ? Icons.favorite_border : Icons.favorite,
                    color: !isFavorite ? Palette.grey : Palette.seedColor,
                  ),
                );
              },
            ),
            if (hasRegenrateButton!)
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Receptas atnaujintas'),
                    ),
                  );
                },
              ),
            FilledButton(
              child: Text('Atgal'),
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
