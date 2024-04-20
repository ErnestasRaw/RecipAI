namespace ReceptAI.Core.Models
{
    public enum FoodCategory
    {
        GrainsAndCereals =1,
        FruitsAndVegetables,
        MeatAndPoultry,
        FishAndSeafood,
        DairyProducts,
        SnacksAndSweets,
        CondimentsAndSauces,
        Beverages,
        FrozenFoods,
        CannedGoods,
        BakedGoods,
        Other
    }

    public class Ingredient
    {
        public int IngredientId { get; set; }
        public string Name { get; set; }
        public FoodCategory CategoryId { get; set; }
    }
}
