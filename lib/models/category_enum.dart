enum ProductCategory {
  grainsAndCereals('Grūdai ir grūdų produktai', 1),
  fruitsAndVegetables('Daržovės ir vaisiai', 2),
  meatAndPoultry('Mėsa ir paukštiena', 3),
  fishAndSeafood('Žuvis ir jūros gėrybės', 4),
  dairyProducts('Pieno produktai', 5),
  snacksAndSweets('Užkandžiai ir saldumynai', 6),
  condimentsAndSauces('Prieskoniai ir padažai', 7),
  beverages('Gėrimai', 8),
  frozenFoods('Šaldyti produktai', 9),
  cannedGoods('Konservuoti produktai', 10),
  bakedGoods('Kepiniai', 11),
  other('Kita', 12);

  final String label;
  final int id;

  const ProductCategory(this.label, this.id);

  static ProductCategory fromId(int id) {
    return ProductCategory.values.firstWhere((element) => element.id == id);
  }
}
