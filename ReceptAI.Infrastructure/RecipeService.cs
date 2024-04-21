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

        public async Task<Recipe> GenerateRecipeAsync(List<Ingredient> ingredients)
        {
            var openAIApi = _openAiFactory.Create();
            var results = await openAIApi.Chat
                .RequestWithUserMessage(MakePrompt(ingredients))
                .WithModel(ChatModelType.Gpt35Turbo)
                .WithTemperature(0.1)
                .ExecuteAsync();

            var allText = results.Choices[0].Message.Content;
            var recipe = FromJson(allText);
            await _recipeRepository.AddRecipeAsync(recipe);

            return recipe;
        }

        public async Task AddRecipeToFavouriteAsync(int userId, int recipeId )
        {
            await _recipeRepository.AddRecipeToFavouriteAsync(userId, recipeId);
        }

        public async Task DeleteFavouriteRecipe(int recipeId)
        {
            await _recipeRepository.DeleteFavouriteRecipeAsync(recipeId);
        }

        public async Task<IEnumerable<Recipe>> GetAllFavouriteRecipesAsync(int userId)
        {
            return await _recipeRepository.GetFavouriteRecipesIdAsync(userId);
        }

        public async Task<IEnumerable<Ingredient>> GetAllIngredientsAsync(FoodCategory category)
        {
            return await _recipeRepository.GetIngredientsAsync(category);
        }

        public string MakePrompt(List<Ingredient> ingredients)
        {
            string prompt = "Generate me a recipe that i could use if i only have: ";
            foreach (var ingredient in ingredients)
            {
                prompt += ingredient.Name + ", ";
            }
            prompt += "in this stucture: Name, ingredients, instructions in json as text. write ingredients and instructions in a list. ";

            return prompt;
        }

        public static Recipe FromJson(string json)
        {
            var recipeJson = JObject.Parse(json);
            var recipeData = recipeJson["recipe"];

            var recipe = new Recipe
            {
                Name = recipeData["name"].ToString(),
                Ingredients = string.Join("\n", recipeData["ingredients"].ToObject<List<string>>()),
                Instructions = string.Join("\n", recipeData["instructions"].ToObject<List<string>>())
            };

            return recipe;
        }
    }
}
