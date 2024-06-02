import 'package:receptai/models/category_enum.dart';
import 'package:receptai/models/ingredient.dart';
import 'package:test/test.dart';

void main() {
  group('Ingredient', () {
    test('creates ingredient from JSON', () {
      final json = {
        'ingredientId': 1,
        'name': 'Apple',
        'categoryId': 2,
      };

      final ingredient = Ingredient.fromJson(json);

      expect(ingredient.ingredientId, equals(1));
      expect(ingredient.name, equals('Apple'));
      expect(ingredient.category, equals(ProductCategory.fruitsAndVegetables));
    });

    test('creates JSON from ingredient', () {
      final ingredient = Ingredient(
        ingredientId: 1,
        name: 'Apple',
        category: ProductCategory.fruitsAndVegetables,
      );

      final json = ingredient.toJson();

      expect(json['ingredientId'], equals(1));
      expect(json['name'], equals('Apple'));
      expect(json['categoryId'], equals(1));
    });
  });
}
