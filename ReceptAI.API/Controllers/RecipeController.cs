using Microsoft.AspNetCore.Mvc;
using ReceptAI.Core.Interfaces;
using ReceptAI.Core.Models;
using Swashbuckle.AspNetCore.Annotations;

namespace ReceptAi.Controllers
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

        [HttpPost("GenerateRecipe", Name = "GenerateRecipe")]
        [SwaggerOperation(Summary = "Generates a recipe based on provided ingredients", Description = "Provides a recipe", OperationId = "GetRecipe")]
		public async Task<IActionResult> GenerateRecipe([FromBody] List<int> ingredientIds)
		{
			try
			{
				if (ingredientIds.Any(id => id < 0))
				{
					return BadRequest(new ResponseWrapper<Recipe>(null, false));
				}

				var ingredients = (List<Ingredient>)await _recipeService.GetIngredientsByIdsAsync(ingredientIds);
				var recipe = await _recipeService.GenerateRecipeAsync(ingredients);
				return Ok(new ResponseWrapper<Recipe>(recipe));
			}
			catch (Exception ex)
			{
				return BadRequest(new ResponseWrapper<Recipe>(null, false));
			}
		}

		[HttpPost("AddRecipeToFavourite/{userId}/{recipeId}", Name = "AddRecipeToFavourite")]
        [SwaggerOperation(Summary = "Adds a recipe to a user's favorites", Description = "Adds a new favorite recipe for the specified user", OperationId = "AddRecipeToFavourite")]
		public async Task<IActionResult> AddRecipeToFavourite(int userId, int recipeId)
		{
			try
			{
				await _recipeService.AddRecipeToFavouriteAsync(userId, recipeId);
				return Ok(new ResponseWrapper<bool>(true));
			}
			catch (Exception ex)
			{
				return BadRequest(new ResponseWrapper<bool>(false, false));
			}
		}

		[HttpGet("GetAllFavouriteRecipes/{userId}", Name = "GetAllFavouriteRecipes")]
        [SwaggerOperation(Summary = "Gets all favorite recipes of a user", Description = "Returns all recipes marked as favorite by the specified user", OperationId = "GetAllUserRecipes")]
		public async Task<IActionResult> GetAllFavouriteRecipes(int userId)
		{
			try
			{
				var recipes = await _recipeService.GetAllFavouriteRecipesAsync(userId);
				return Ok(new ResponseWrapper<IEnumerable<Recipe>>(recipes));
			}
			catch (Exception ex)
			{
				return BadRequest(new ResponseWrapper<IEnumerable<Recipe>>(null, false));
			}
		}

		[HttpDelete("DeleteFavouriteRecipe/{recipeId}", Name = "DeleteFavouriteRecipe")]
        [SwaggerOperation(Summary = "Deletes a recipe", Description = "Deletes the specified recipe from the database", OperationId = "DeleteRecipe")]
		public async Task<IActionResult> DeleteFavouriteRecipe(int recipeId)
		{
			try
			{
				await _recipeService.DeleteFavouriteRecipe(recipeId);
				return Ok(new ResponseWrapper<bool>(true));
			}
			catch (Exception ex)
			{
				return BadRequest(new ResponseWrapper<bool>(false, false));
			}
		}

		[HttpGet("GetIngredients/{categoryId}", Name = "GetIngredients")]
        [SwaggerOperation(Summary = "Gets all ingredients of a specified category", Description = "Returns all ingredients of the specified category", OperationId = "GetIngredients")]
		public async Task<IActionResult> GetIngredients(FoodCategory categoryId)
		{
			try
			{
				var ingredients = await _recipeService.GetAllIngredientsAsync(categoryId);
				return Ok(new ResponseWrapper<IEnumerable<Ingredient>>(ingredients));
			}
			catch (Exception ex)
			{
				return BadRequest(new ResponseWrapper<IEnumerable<Ingredient>>(null, false));
			}
		}
	}
}
