using Microsoft.EntityFrameworkCore;
using ReceptAI.Core.Interfaces;
using ReceptAI.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ReceptAI.Infrastructure
{
	public class RecipeRepository : IRecipeRepository
	{
		private readonly AppDbContext _context;
		private readonly IValidationService _validationService;

		public RecipeRepository(AppDbContext context, IValidationService validationService)
		{
			_context = context;
			_validationService = validationService;
		}

		public async Task<IEnumerable<Recipe>> GetFavouriteRecipesIdAsync(int userId)
		{
			_validationService.ValidateUserId(userId);
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
			_validationService.ValidateUserId(userId);
			_validationService.ValidateRecipeId(recipeId);

			var recipe = await _context.Recipes.FindAsync(recipeId);
			if (recipe == null)
			{
				throw new ArgumentException("Recipe not found.");
			}

			var existingFavourite = await _context.Recipes
										.AnyAsync(r => r.RecipeId == recipeId && r.UserId == userId);
			if (existingFavourite)
			{
				throw new InvalidOperationException("Recipe is already marked as favourite.");
			}

			recipe.UserId = userId;
			await _context.SaveChangesAsync();
		}

		public async Task DeleteFavouriteRecipeAsync(int id)
		{
			_validationService.ValidateRecipeId(id);
			var recipe = await _context.Recipes.Where(x => x.RecipeId == id).FirstOrDefaultAsync();
			if (recipe == null)
			{
				throw new KeyNotFoundException("Recipe not found for deletion.");
			}

			_context.Recipes.Remove(recipe);
			await _context.SaveChangesAsync();
		}

		public async Task<IEnumerable<Ingredient>> GetIngredientsAsync(FoodCategory category)
		{
			if (category == null)
			{
				throw new ArgumentNullException(nameof(category));
			}

			return await _context.Ingredients
						  .Where(ingredient => ingredient.CategoryId == category)
						  .ToListAsync();
		}

		public async Task<IEnumerable<Ingredient>> GetIngredientsByIdsAsync(List<int> ingredientIds)
		{
			if (ingredientIds == null || !ingredientIds.Any())
			{
				throw new ArgumentException("Ingredient IDs cannot be null or empty.", nameof(ingredientIds));
			}

			return await _context.Ingredients
						  .Where(ingredient => ingredientIds.Contains(ingredient.IngredientId))
						  .ToListAsync();
		}
	}

	public interface IValidationService
	{
		void ValidateUserId(int userId);
		void ValidateRecipeId(int recipeId);
	}

	public class ValidationService : IValidationService
	{
		public void ValidateUserId(int userId)
		{
			if (userId <= 0)
			{
				throw new ArgumentException("Invalid user ID.");
			}
		}

		public void ValidateRecipeId(int recipeId)
		{
			if (recipeId <= 0)
			{
				throw new ArgumentException("Invalid recipe ID.");
			}
		}
	}
}
