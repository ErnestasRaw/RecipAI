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

        [HttpPost("GetRecipe")]
        [SwaggerOperation(Summary = "Generates a recipe based on provided ingredients", Description = "Provides a recipe", OperationId = "GetRecipe")]
        public async Task<Recipe> GetRecipe([FromBody] List<Ingredient> ingredients)
        {
            return await _recipeService.GetRecipeAsync(ingredients);
        }

        [HttpPost("AddRecipeToFavourite/{userId}", Name = "AddRecipeToFavourite")]
        [SwaggerOperation(Summary = "Adds a recipe to a user's favorites", Description = "Adds a new favorite recipe for the specified user", OperationId = "AddRecipeToFavourite")]
        public async Task<IActionResult> AddRecipeToFavourite([FromBody] Recipe recipe, int userId)
        {
            await _recipeService.AddRecipeToFavouriteAsync(recipe, userId);
            return Ok();
        }

        [HttpGet("GetAllUserRecipes/{userId}", Name = "GetAllUserRecipes")]
        [SwaggerOperation(Summary = "Gets all favorite recipes of a user", Description = "Returns all recipes marked as favorite by the specified user", OperationId = "GetAllUserRecipes")]
        public async Task<IEnumerable<Recipe>> GetAllUserRecipes(int userId)
        {
            return await _recipeService.GetAllRecipesAsync(userId);
        }

        [HttpDelete("DeleteRecipe/{recipeId}", Name = "DeleteRecipe")]
        [SwaggerOperation(Summary = "Deletes a recipe", Description = "Deletes the specified recipe from the database", OperationId = "DeleteRecipe")]
        public async Task<IActionResult> DeleteRecipe(int recipeId)
        {
            await _recipeService.DeleteRecipe(recipeId);
            return Ok();
        }
    }
}
