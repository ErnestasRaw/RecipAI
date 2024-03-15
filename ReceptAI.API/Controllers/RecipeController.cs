using Microsoft.AspNetCore.Mvc;

namespace ReceptAi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class RecipeController : ControllerBase
    {
        private IRecipeService _recipeService;
        public RecipeController(IRecipeService recipeService)
        {
            _recipeService = recipeService;
        }

        [HttpPost(Name = "GetRecipe")]
        public async Task<Recipe> GetRecipe([FromBody]List<Ingredient> ingredients)
        {
           return await _recipeService.GetRecipeAsync(ingredients);
        }
    }
}
