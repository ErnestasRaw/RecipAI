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
            return await _recipeService.GenerateRecipeAsync(ingredients);
        }

        [HttpPost("AddRecipeToFavourite/{userId}/{recipeId}", Name = "AddRecipeToFavourite")]
        [SwaggerOperation(Summary = "Adds a recipe to a user's favorites", Description = "Adds a new favorite recipe for the specified user", OperationId = "AddRecipeToFavourite")]
        public async Task<IActionResult> AddRecipeToFavourite( int userId,int recipeId)
        {
            await _recipeService.AddRecipeToFavouriteAsync(userId,recipeId );
            return Ok();
        }

        [HttpGet("GetAllFavouriteRecipes/{userId}", Name = "GetAllFavouriteRecipes")]
        [SwaggerOperation(Summary = "Gets all favorite recipes of a user", Description = "Returns all recipes marked as favorite by the specified user", OperationId = "GetAllUserRecipes")]
        public async Task<IEnumerable<Recipe>> GetAllFavouriteRecipes(int userId)
        {
            return await _recipeService.GetAllFavouriteRecipesAsync(userId);
        }

        [HttpDelete("DeleteFavouriteRecipe/{recipeId}", Name = "DeleteFavouriteRecipe")]
        [SwaggerOperation(Summary = "Deletes a recipe", Description = "Deletes the specified recipe from the database", OperationId = "DeleteRecipe")]
        public async Task<IActionResult> DeleteFavouriteRecipe(int recipeId)
        {
            await _recipeService.DeleteFavouriteRecipe(recipeId);
            return Ok();
        }

        [HttpGet("GetIngredients/{categoryId}", Name = "GetIngredients")]
        public async Task<IEnumerable<Ingredient>> GetIngredients(FoodCategory categoryId)
        {
            return await _recipeService.GetAllIngredientsAsync(categoryId);
        }
    }
}
