using Newtonsoft.Json.Linq;
using Rystem.OpenAi;
using ReceptAI.Core.Models;
using ReceptAI.Core.Interfaces;

namespace ReceptAI.Infrastructure
{
    public class RecipeService : IRecipeService
    {
        private readonly IOpenAiFactory _openAiFactory;
        private readonly IRecipeRepository _recipeRepository;

        public RecipeService(IOpenAiFactory openAIService, IRecipeRepository recipeRepository)
        {
            _openAiFactory = openAIService;
            _recipeRepository = recipeRepository;
        }

        public async Task<Recipe> GetRecipeAsync(List<Ingredient> ingredients)
        {
            var openAiApi = _openAiFactory.Create();
            var results = await openAiApi.Chat
                .RequestWithUserMessage(MakePrompt(ingredients))
                .WithModel(ChatModelType.Gpt35Turbo)
                .WithTemperature(0.1)
                .ExecuteAsync();

            var allText = results.Choices[0].Message.Content;
            var recipe = FromJson(allText);

            return recipe;
        }

        public async Task AddRecipeToFavouriteAsync(Recipe recipe, int userId)
        {
            recipe.UserId = userId;
            await _recipeRepository.AddAsync(recipe);
        }
        public async Task DeleteRecipe(int recipeId)
        {
            await _recipeRepository.DeleteAsync(recipeId);
        }

        public async Task<IEnumerable<Recipe>> GetAllRecipesAsync(int id)
        {
            return await _recipeRepository.GetAllRecipesByUserIdAsync(id);
        }

        public string MakePrompt(List<Ingredient> ingredients)
        {
            string prompt = "Generate me a recipe that i could use if i only have: ";
            foreach (var ingredient in ingredients)
            {
                prompt += ingredient.Name + " " + ingredient.Quantity + ", ";
            }
            prompt += "in this stucture: Name, ingredients, instructions in JSON.each ingredient have name and quantity ";

            return prompt;
        }

        public static Recipe FromJson(string json)
        {
            var recipeJson = JObject.Parse(json);
            var recipeData = recipeJson["recipe"];

            var recipe = new Recipe
            {
                Name = recipeData["name"].ToString(),
                Ingredients = recipeData["ingredients"].ToObject<List<Ingredient>>(),
                Instructions = string.Join("\n", recipeData["instructions"].ToObject<List<string>>())
            };

            return recipe;
        }

        
    }
}
