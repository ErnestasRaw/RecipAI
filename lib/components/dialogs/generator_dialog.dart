import 'package:flutter/material.dart';
import 'package:receptai/components/theme/palette.dart';
import 'package:receptai/components/theme/styles.dart';
import 'package:receptai/models/recipe.dart';

class GeneratorDialog {
  static Future<void> show(BuildContext context, {bool? hasRegenrateButton = true}) async {
    bool isFavorite = false;
    Recipe recipe = Recipe(
      recipeId: 1,
      name: 'Morkų sriuba',
      ingredients: [
        'Morkos',
        'Bulvės',
        'Pomidorai',
      ],
      instructions:
          '1. Nulupkite morkas ir bulves. 2. Nuplaukite pomidorus. 3. Sudėkite visus ingredientus į puodą ir užpilkite vandeniu. 4. Virkite 30 minučių.',
    );
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
