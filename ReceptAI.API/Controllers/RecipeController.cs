using Microsoft.AspNetCore.Mvc;
using ReceptAI.Core.Interfaces;
using ReceptAI.Core.Models;
using Swashbuckle.AspNetCore.Annotations;

namespace ReceptAI.Controllers
{
	[ApiController]
	[Route("[controller]")]
	public class RecipeController : ControllerBase
	{
		private readonly IRecipeService _recipeService;

		public RecipeController(IRecipeService recipeService)
		{
			_recipeService = recipeService;
		}

		private async Task<IActionResult> HandleRequestAsync<T>(Func<Task<T>> action)
		{
			try
			{
				var result = await action();
				return Ok(new ResponseWrapper<T>(result, true));
			}
			catch (Exception ex)
			{
				return BadRequest(new ResponseWrapper<T>(default, false));
			}
		}

		[HttpPost("GenerateRecipe", Name = "GenerateRecipe")]
		[SwaggerOperation(Summary = "Generates a recipe based on provided ingredients", Description = "Provides a recipe", OperationId = "GetRecipe")]
		public async Task<IActionResult> GenerateRecipe([FromBody] List<int> ingredientIds)
		{
			if (ingredientIds.Any(id => id < 0))
			{
				return BadRequest(new ResponseWrapper<Recipe>(null, false));
			}

			return await HandleRequestAsync(async () =>
			{
				var ingredients = (List<Ingredient>)await _recipeService.GetIngredientsByIdsAsync(ingredientIds);
				return await _recipeService.GenerateRecipeAsync(ingredients);
			});
		}

		[HttpPost("AddRecipeToFavourite/{userId}/{recipeId}", Name = "AddRecipeToFavourite")]
		[SwaggerOperation(Summary = "Adds a recipe to a user's favorites", Description = "Adds a new favorite recipe for the specified user", OperationId = "AddRecipeToFavourite")]
		public async Task<IActionResult> AddRecipeToFavourite(int userId, int recipeId)
		{
			return await HandleRequestAsync(async () =>
			{
				await _recipeService.AddRecipeToFavouriteAsync(userId, recipeId);
				return true;
			});
		}

		[HttpGet("GetAllFavouriteRecipes/{userId}", Name = "GetAllFavouriteRecipes")]
		[SwaggerOperation(Summary = "Gets all favorite recipes of a user", Description = "Returns all recipes marked as favorite by the specified user", OperationId = "GetAllUserRecipes")]
		public async Task<IActionResult> GetAllFavouriteRecipes(int userId)
		{
			return await HandleRequestAsync(() => _recipeService.GetAllFavouriteRecipesAsync(userId));
		}

		[HttpDelete("DeleteFavouriteRecipe/{recipeId}", Name = "DeleteFavouriteRecipe")]
		[SwaggerOperation(Summary = "Deletes a recipe", Description = "Deletes the specified recipe from the database", OperationId = "DeleteRecipe")]
		public async Task<IActionResult> DeleteFavouriteRecipe(int recipeId)
		{
			return await HandleRequestAsync(async () =>
			{
				await _recipeService.DeleteFavouriteRecipe(recipeId);
				return true;
			});
		}

		[HttpGet("GetIngredients/{categoryId}", Name = "GetIngredients")]
		[SwaggerOperation(Summary = "Gets all ingredients of a specified category", Description = "Returns all ingredients of the specified category", OperationId = "GetIngredients")]
		public async Task<IActionResult> GetIngredients(FoodCategory categoryId)
		{
			return await HandleRequestAsync(() => _recipeService.GetAllIngredientsAsync(categoryId));
		}
	}
}
