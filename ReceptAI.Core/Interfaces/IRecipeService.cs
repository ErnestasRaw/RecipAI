using ReceptAI.Core.Models;

namespace ReceptAI.Core.Interfaces
{
    public interface IRecipeService
    {
        Task AddRecipeToFavouriteAsync(Recipe recipe, int userId);
        Task<Recipe> GetRecipeAsync(List<Ingredient> ingredients);
        Task<IEnumerable<Recipe>> GetAllRecipesAsync(int userId);
        Task DeleteRecipe(int recipeId);

    }
}
