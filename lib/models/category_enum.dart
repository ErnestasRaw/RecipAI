enum ProductCategory {
  grainsAndCereals('Grūdai ir grūdų produktai'),
  fruitsAndVegetables('Daržovės ir vaisiai'),
  meatAndPoultry('Mėsa ir paukštiena'),
  fishAndSeafood('Žuvis ir jūros gėrybės'),
  dairyProducts('Pieno produktai'),
  snacksAndSweets('Užkandžiai ir saldumynai'),
  condimentsAndSauces('Prieskoniai ir padažai'),
  beverages('Gėrimai'),
  frozenFoods('Šaldyti produktai'),
  cannedGoods('Konservuoti produktai'),
  bakedGoods('Kepiniai'),
  other('Kita');

  final String label;

  const ProductCategory(this.label);
}
