import 'package:receptai/models/category_enum.dart';
import 'package:test/test.dart';

void main() {
  group('ProductCategory', () {
    test('returns correct category for given id', () {
      expect(ProductCategory.fromId(1), equals(ProductCategory.grainsAndCereals));
      expect(ProductCategory.fromId(2), equals(ProductCategory.fruitsAndVegetables));
      expect(ProductCategory.fromId(3), equals(ProductCategory.meatAndPoultry));
      // Add more assertions for other categories
    });

    test('throws error for invalid id', () {
      expect(() => ProductCategory.fromId(0), throwsA(isA<Error>()));
      expect(() => ProductCategory.fromId(13), throwsA(isA<Error>()));
    });
  });
}
