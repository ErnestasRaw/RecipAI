using Microsoft.AspNetCore.Mvc;
using Moq;
using ReceptAi.Controllers;
using ReceptAI.Core.Interfaces;
using Xunit;

namespace ReceptAI.API.Tests
{
	public class RecipeControllerTests
	{
		private readonly Mock<IRecipeService> _recipeServiceMock;
		private readonly RecipeController _controller;

		public RecipeControllerTests()
		{
			_recipeServiceMock = new Mock<IRecipeService>();
			_controller = new RecipeController(_recipeServiceMock.Object);
		}

		[Fact]
		public async Task DeleteFavouriteRecipe_ReturnsOkResult_WhenRecipeExists()
		{
			// Arrange
			int recipeId = 1;
			_recipeServiceMock.Setup(service => service.DeleteFavouriteRecipe(recipeId)).Returns(Task.CompletedTask);

			// Act
			var result = await _controller.DeleteFavouriteRecipe(recipeId);

			// Assert
			Assert.IsType<OkObjectResult>(result);
			var okResult = result as OkObjectResult;
			var response = okResult.Value as ResponseWrapper<bool>;
			Assert.True(response.Data);
		}

		[Fact]
		public async Task DeleteFavouriteRecipe_ReturnsBadRequestResult_WhenExceptionOccurs()
		{
			// Arrange
			int recipeId = 1;
			_recipeServiceMock.Setup(service => service.DeleteFavouriteRecipe(recipeId)).ThrowsAsync(new System.Exception());

			// Act
			var result = await _controller.DeleteFavouriteRecipe(recipeId);

			// Assert
			Assert.IsType<BadRequestObjectResult>(result);
			var badRequestResult = result as BadRequestObjectResult;
			var response = badRequestResult.Value as ResponseWrapper<bool>;
			Assert.False(response.Data);
		}
	}
}
