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

        public async Task<Recipe> GetRecipeByIdAsync(int id)
        {
            return await _context.Recipes.FindAsync(id);
        }

        public async Task<IEnumerable<Recipe>> GetAllRecipesByUserIdAsync(int userId)
        {
            return await _context.Recipes
                        .Where(r => r.UserId == userId)
                        .Include(r => r.Ingredients)
                        .ToListAsync();
        }

        public async Task AddAsync(Recipe recipe)
        {
            await _context.Recipes.AddAsync(recipe);
            await _context.SaveChangesAsync();
        }

        public async Task UpdateAsync(Recipe recipe)
        {
            _context.Recipes.Update(recipe);
            await _context.SaveChangesAsync();
        }

        public async Task DeleteAsync(int id)
        {
            var recipe = await _context.Recipes
                                .Include(r => r.Ingredients) 
                                .FirstOrDefaultAsync(r => r.RecipeId == id);

            if (recipe != null)
            {
                _context.Ingredients.RemoveRange(recipe.Ingredients);
                _context.Recipes.Remove(recipe);

                await _context.SaveChangesAsync();
            }
        }
    }
}
