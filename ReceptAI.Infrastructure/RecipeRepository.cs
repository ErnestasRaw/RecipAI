using Microsoft.EntityFrameworkCore;
using ReceptAI.Core.Interfaces;
using ReceptAI.Core.Models;

namespace ReceptAI.Infrastructure
{
    public class RecipeRepository : IRecipeRepository
    {
        private readonly AppDbContext _context;

        public RecipeRepository(AppDbContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<Recipe>> GetFavouriteRecipesIdAsync(int userId)
        {
            return await _context.Recipes
                        .Where(r => r.UserId == userId)
                        .ToListAsync();
        }

        public async Task AddRecipeAsync(Recipe recipe)
        {
            await _context.Recipes.AddAsync(recipe);
            await _context.SaveChangesAsync();
        }

        public async Task AddRecipeToFavouriteAsync(int userId, int recipeId)
        {
            var recipe = await _context.Recipes.FindAsync(recipeId);

            if (recipe != null)
            {           
                recipe.UserId = userId;
                await _context.SaveChangesAsync();
            }
        }

        public async Task DeleteFavouriteRecipeAsync(int id)
        {
            var recipe = await _context.Recipes.Where(x => x.RecipeId == id).FirstOrDefaultAsync();

            if (recipe != null)
            {
                _context.Recipes.Remove(recipe);

                await _context.SaveChangesAsync();
            }
        }

        public async Task<IEnumerable<Ingredient>> GetIngredientsAsync(FoodCategory category)
        {
            return await _context.Ingredients
                          .Where(ingredient => ingredient.CategoryId == category)
                          .ToListAsync();
        }
    }
}
