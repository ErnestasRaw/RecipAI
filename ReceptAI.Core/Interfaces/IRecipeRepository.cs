using ReceptAI.Core.Models;

namespace ReceptAI.Core.Interfaces
{
    public interface IRecipeRepository
    {
        Task<IEnumerable<Recipe>> GetFavouriteRecipesIdAsync(int userId);
        Task AddRecipeToFavouriteAsync(int userId, int recipeId);
        Task DeleteFavouriteRecipeAsync(int id);
        Task AddRecipeAsync(Recipe recipe);
        //
        Task<IEnumerable<Ingredient>> GetIngredientsAsync(FoodCategory category);


    }
}
