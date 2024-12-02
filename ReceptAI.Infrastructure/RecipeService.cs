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

		private const string RecipePromptTemplate =
			"Generate me a recipe that i could use if i only have: {0} in this structure: Name, ingredients, instructions in json as text. Write ingredients and instructions in a list.";

		public RecipeService(IOpenAiFactory openAIService, IRecipeRepository recipeRepository)
		{
			_openAiFactory = openAIService;
			_recipeRepository = recipeRepository;
		}

		public async Task<Recipe> GenerateRecipeAsync(List<Ingredient> ingredients)
		{
			if (ingredients == null || !ingredients.Any())
				throw new ArgumentNullException(nameof(ingredients));

			var openAIApi = _openAiFactory.Create();
			var results = await openAIApi.Chat
				.RequestWithUserMessage(MakePrompt(ingredients))
				.WithModel(ChatModelType.Gpt35Turbo)
				.WithTemperature(0.1)
				.ExecuteAsync();

			if (results?.Choices == null || results.Choices.Count == 0 || results.Choices[0].Message?.Content == null)
				throw new InvalidOperationException("AI response is invalid or empty.");

			var allText = results.Choices[0].Message.Content;
			var recipe = FromJson(allText);

			if (recipe == null)
				throw new InvalidDataException("Failed to parse recipe from AI response.");

			await _recipeRepository.AddRecipeAsync(recipe);

			return recipe;
		}

		public async Task AddRecipeToFavouriteAsync(int userId, int recipeId)
		{
			if (userId <= 0)
				throw new ArgumentException("User ID must be a positive number.", nameof(userId));
			if (recipeId <= 0)
				throw new ArgumentException("Recipe ID must be a positive number.", nameof(recipeId));

			await ExecuteRepositoryActionAsync(() => _recipeRepository.AddRecipeToFavouriteAsync(userId, recipeId));
		}

		public async Task DeleteFavouriteRecipe(int recipeId)
		{
			if (recipeId <= 0)
				throw new ArgumentException("Recipe ID must be a positive number.", nameof(recipeId));

			await ExecuteRepositoryActionAsync(() => _recipeRepository.DeleteFavouriteRecipeAsync(recipeId));
		}

		public async Task<IEnumerable<Recipe>> GetAllFavouriteRecipesAsync(int userId)
		{
			if (userId <= 0)
				throw new ArgumentException("User ID must be a positive number.", nameof(userId));

			return await _recipeRepository.GetFavouriteRecipesIdAsync(userId);
		}

		public async Task<IEnumerable<Ingredient>> GetAllIngredientsAsync(FoodCategory category)
		{
			return await _recipeRepository.GetIngredientsAsync(category);
		}

		public async Task<IEnumerable<Ingredient>> GetIngredientsByIdsAsync(List<int> ingredientIds)
		{
			if (ingredientIds == null || !ingredientIds.Any())
				throw new ArgumentNullException(nameof(ingredientIds));

			return await _recipeRepository.GetIngredientsByIdsAsync(ingredientIds);
		}

		public string MakePrompt(List<Ingredient> ingredients)
		{
			if (ingredients == null || !ingredients.Any())
				throw new ArgumentNullException(nameof(ingredients));

			string ingredientList = string.Join(", ", ingredients.Select(i => i.Name));
			return string.Format(RecipePromptTemplate, ingredientList);
		}

		public static Recipe FromJson(string json)
		{
			var recipeJson = JObject.Parse(json);
			if (recipeJson["recipe"] == null)
				throw new InvalidDataException("Invalid JSON structure: 'recipe' section is missing.");

			var recipeData = recipeJson["recipe"];
			return MapToRecipe(recipeData);
		}

		private static Recipe MapToRecipe(JToken recipeData)
		{
			return new Recipe
			{
				Name = recipeData["name"]?.ToString() ?? throw new InvalidDataException("Recipe name is missing."),
				Ingredients = string.Join("\n", recipeData["ingredients"]?.ToObject<List<string>>() ?? new List<string>()),
				Instructions = string.Join("\n", recipeData["instructions"]?.ToObject<List<string>>() ?? new List<string>())
			};
		}

		private async Task ExecuteRepositoryActionAsync(Func<Task> repositoryAction)
		{
			try
			{
				await repositoryAction();
			}
			catch (Exception ex)
			{
				throw new Exception("An error occurred while processing the request.", ex);
			}
		}
	}
}
