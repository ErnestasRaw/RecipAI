using ReceptAI.Core.Models;

namespace ReceptAI.Core.Interfaces
{
    public interface IRecipeService
    {
        Task<Recipe> GenerateRecipeAsync(List<Ingredient> ingredients);
        Task AddRecipeToFavouriteAsync(int userId, int recipeId);
        Task<IEnumerable<Recipe>> GetAllFavouriteRecipesAsync(int userId);
        Task DeleteFavouriteRecipe(int recipeId);
        Task<IEnumerable<Ingredient>> GetAllIngredientsAsync(FoodCategory category);
    }
}
