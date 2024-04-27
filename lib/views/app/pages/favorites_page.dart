import 'package:flutter/material.dart';
import 'package:receptai/components/theme/palette.dart';
import 'package:receptai/components/theme/styles.dart';
import 'package:receptai/models/recipe.dart';
import 'package:receptai/views/app/pages/home_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [],
      ),
    );
  }

  Widget _buildRecipeCard(Recipe recipe) {
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
          //  GeneratorDialog.show(context, hasRegenrateButton: false);
        },
      ),
    );
  }
}
