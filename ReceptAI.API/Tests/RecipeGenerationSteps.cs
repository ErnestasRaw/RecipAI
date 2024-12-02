using Xunit;
using Moq;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using ReceptAI.Core.Models;
using ReceptAI.Core.Interfaces;
using ReceptAI.API.Controllers; // Correct namespace for the controller
using TechTalk.SpecFlow;
using ReceptAI.Controllers;

namespace ReceptAI.Tests
{
	[Binding]
	public class RecipeControllerTests
	{
		private readonly Mock<IRecipeService> _recipeServiceMock;
		private readonly RecipeController _recipeController;

		public RecipeControllerTests()
		{
			_recipeServiceMock = new Mock<IRecipeService>();
			_recipeController = new RecipeController(_recipeServiceMock.Object);
		}

		[Given(@"I have the following valid ingredients ids: (.*)")]
		public void GivenIHaveTheFollowingValidIngredientsIds(string ingredients)
		{
			var ingredientIds = ingredients.Split(',').Select(int.Parse).ToArray();
			_recipeServiceMock.Setup(service => service.GetIngredientsByIdsAsync(ingredientIds.ToList())) // Convert array to list
				.Returns(Task.FromResult((IEnumerable<Ingredient>)new List<Ingredient> { new Ingredient(), new Ingredient(), new Ingredient() }));
		}

		[When(@"I request to generate a recipe with valid ingredients")]
		public async Task WhenIRequestToGenerateARecipeWithValidIngredients()
		{
			var result = await _recipeController.GenerateRecipe(new List<int> { 1, 2, 3 });
			Assert.IsType<OkObjectResult>(result);
		}

		[When(@"I request to generate a recipe with invalid ingredients")]
		public async Task WhenIRequestToGenerateARecipeWithInvalidIngredients()
		{
			var result = await _recipeController.GenerateRecipe(new List<int> { -500, -501 });
			Assert.IsType<BadRequestObjectResult>(result);
		}


		[Then(@"the response should be an OK result with a valid recipe")]
		public void ThenTheResponseShouldBeAnOKResultWithAValidRecipe()
		{
			_recipeServiceMock.Verify(service => service.GenerateRecipeAsync(It.IsAny<List<Ingredient>>()), Times.Once); // Change IEnumerable to List
		}

		[Given(@"I have the following invalid ingredients ids: (.*)")]
		public void GivenIHaveTheFollowingInvalidIngredientsIds(string ingredients)
		{
			var ingredientIds = ingredients.Split(',').Select(int.Parse).ToArray();
			_recipeServiceMock.Setup(service => service.GetIngredientsByIdsAsync(ingredientIds.ToList())) // Convert array to list
				.Returns(Task.FromResult((IEnumerable<Ingredient>)new List<Ingredient>()));
		}

		[Then(@"the response should be a BadRequest result")]
		public async Task ThenTheResponseShouldBeABadRequestResult()
		{
			var result = await _recipeController.GenerateRecipe(new List<int> { -500, -501 });
			Assert.IsType<BadRequestObjectResult>(result);
		}


	}
}
