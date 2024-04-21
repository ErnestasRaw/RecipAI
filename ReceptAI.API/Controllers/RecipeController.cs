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
        public async Task<Recipe> GenerateRecipe([FromBody] List<Ingredient> ingredients)
        {
            try
            {
                return await _recipeService.GenerateRecipeAsync(ingredients);
            }
            catch (Exception)
            {
                throw;
            }
        }

        [HttpPost("AddRecipeToFavourite/{userId}/{recipeId}", Name = "AddRecipeToFavourite")]
        [SwaggerOperation(Summary = "Adds a recipe to a user's favorites", Description = "Adds a new favorite recipe for the specified user", OperationId = "AddRecipeToFavourite")]
        public async Task<IActionResult> AddRecipeToFavourite( int userId,int recipeId)
        {
            try
            {
                await _recipeService.AddRecipeToFavouriteAsync(userId, recipeId);
                return Ok();
            }
            catch (Exception)
            {
                throw;
            }
        }

        [HttpGet("GetAllFavouriteRecipes/{userId}", Name = "GetAllFavouriteRecipes")]
        [SwaggerOperation(Summary = "Gets all favorite recipes of a user", Description = "Returns all recipes marked as favorite by the specified user", OperationId = "GetAllUserRecipes")]
        public async Task<IEnumerable<Recipe>> GetAllFavouriteRecipes(int userId)
        {
            try
            {
                return await _recipeService.GetAllFavouriteRecipesAsync(userId);
            }
            catch (Exception)
            {
                throw;
            }
        }

        [HttpDelete("DeleteFavouriteRecipe/{recipeId}", Name = "DeleteFavouriteRecipe")]
        [SwaggerOperation(Summary = "Deletes a recipe", Description = "Deletes the specified recipe from the database", OperationId = "DeleteRecipe")]
        public async Task<IActionResult> DeleteFavouriteRecipe(int recipeId)
        {
            try
            {
                await _recipeService.DeleteFavouriteRecipe(recipeId);
                return Ok();
            }
            catch (Exception)
            {
                throw;
            }
        }

        [HttpGet("GetIngredients/{categoryId}", Name = "GetIngredients")]
        [SwaggerOperation(Summary = "Gets all ingredients of a specified category", Description = "Returns all ingredients of the specified category", OperationId = "GetIngredients")]
        public async Task<IEnumerable<Ingredient>> GetIngredients(FoodCategory categoryId)
        {
            try
            {
                return await _recipeService.GetAllIngredientsAsync(categoryId);
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
