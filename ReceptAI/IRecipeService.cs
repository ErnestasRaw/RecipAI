namespace ReceptAi
{
    public interface IRecipeService
    {
       Task<Recipe> GetRecipeAsync(List<Ingredient> ingredients);

    }
}
