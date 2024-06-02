import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:receptai/api/recipe_api.dart';
import 'package:receptai/components/dialogs/generator_dialog.dart';
import 'package:receptai/components/theme/sizes.dart';
import 'package:receptai/models/category_enum.dart';
import 'package:receptai/models/recipe.dart';
import 'package:receptai/views/app/pages/controllers/generator_controller.dart';

class GeneratorPage extends StatefulWidget {
  const GeneratorPage({super.key});

  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  final GeneratorController generatorController = GeneratorController();
  bool isFetched = false;

  Future<void> init() async {
    await generatorController.fetchIngredients();
    setState(() {
      isFetched = true;
    });
  }

  @override
  initState() {
    super.initState();
    init();
  }

  Future<void> onCategoryChange(ProductCategory? value) async {
    await generatorController.onCategoryChanged(value!);
    setState(() {});
  }

  Future<void> onGeneratePressed() async {
    Response response = await RecipeApi.generateRecipe(
      generatorController.selectedIngredients,
    );
    Recipe recipe = Recipe.fromJson(response.data['data']);
    if (response.data['data'] != null) {
      await GeneratorDialog.show(
        context,
        recipe: Recipe.fromJson(response.data['data']),
        onRegenerate: () async {
          Navigator.pop(context);
          await onGeneratePressed();
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nepavyko sugeneruoti recepto'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Sizes.pageMargins,
      child: isFetched
          ? Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<ProductCategory>(
                        value: generatorController.selectedCategory,
                        onChanged: (value) async {
                          await onCategoryChange(value);
                        },
                        isExpanded: true,
                        items: ProductCategory.values
                            .map<DropdownMenuItem<ProductCategory>>(
                              (ProductCategory value) => DropdownMenuItem<ProductCategory>(
                                value: value,
                                child: Text(value.label),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
                ListenableBuilder(
                  listenable: generatorController,
                  builder: (context, _) => Expanded(
                    child: ListView.builder(
                      itemCount: generatorController.fetchedIngredients.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(generatorController.fetchedIngredients[index].name),
                          trailing: Checkbox(
                            value: generatorController.selectedIngredients
                                .contains(generatorController.fetchedIngredients[index].ingredientId),
                            onChanged: (bool? value) {
                              if (value!) {
                                generatorController
                                    .addIngredient(generatorController.fetchedIngredients[index].ingredientId);
                              } else {
                                generatorController
                                    .removeIngredient(generatorController.fetchedIngredients[index].ingredientId);
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () async {
                          await onGeneratePressed();
                        },
                        icon: const Icon(Icons.generating_tokens),
                        label: const Text('Generuoti'),
                      ),
                    ),
                  ],
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
