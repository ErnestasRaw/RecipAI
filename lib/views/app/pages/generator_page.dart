import 'package:flutter/material.dart';
import 'package:receptai/components/dialogs/generator_dialog.dart';
import 'package:receptai/components/theme/sizes.dart';
import 'package:receptai/models/category_enum.dart';
import 'package:receptai/views/app/pages/controllers/generator_controller.dart';

class GeneratorPage extends StatefulWidget {
  const GeneratorPage({super.key});

  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  final GeneratorController generatorController = GeneratorController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Sizes.pageMargins,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButton<ProductCategory>(
                  value: generatorController.selectedCategory,
                  onChanged: (ProductCategory? newValue) {
                    setState(() {
                      generatorController.selectedCategory = newValue!;
                    });
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
          Expanded(
            child: ListView.builder(
              itemCount: generatorController.filteredIngredients.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(generatorController.filteredIngredients.elementAt(index).name),
                  trailing: Checkbox(
                    value: generatorController.selectedIngredients
                        .contains(generatorController.filteredIngredients.elementAt(index)),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value!) {
                          generatorController.selectedIngredients
                              .add(generatorController.filteredIngredients.elementAt(index));
                        } else {
                          generatorController.selectedIngredients
                              .remove(generatorController.filteredIngredients.elementAt(index));
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {
                    GeneratorDialog.show(context);
                  },
                  icon: const Icon(Icons.generating_tokens),
                  label: const Text('Generuoti'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
