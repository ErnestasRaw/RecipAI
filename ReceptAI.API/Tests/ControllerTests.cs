using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Moq;
using Xunit;
using ReceptAi.Controllers;
using ReceptAI.Core.Interfaces;
using ReceptAI.Core.Models;
using ReceptAI.Infrastructure;
using Rystem.OpenAi;
using ReceptAI.API.Controllers;

namespace ReceptAi.Tests
{
    public class ControllerTests
    {
		[Fact]
		public async Task GenerateRecipe_Returns_OkObjectResult_WithRecipe()
		{
			// Arrange
			var mockService = new Mock<IRecipeService>();
			var controller = new RecipeController(mockService.Object);
			var ingredientIds = new List<int>(); // Add this line to match the controller method signature

			var expectedRecipe = new Recipe(); // Assume your service method returns a Recipe object
			var ingredients = new List<Ingredient>(); // This is the list of ingredients that should be returned by GetIngredientsByIdsAsync

			mockService.Setup(x => x.GetIngredientsByIdsAsync(ingredientIds)).ReturnsAsync(ingredients);
			mockService.Setup(x => x.GenerateRecipeAsync(ingredients)).ReturnsAsync(expectedRecipe);

			// Act
			var result = await controller.GenerateRecipe(ingredientIds);

			// Assert
			var okResult = Assert.IsType<OkObjectResult>(result); // Assert it's an OkObjectResult

			var responseWrapper = Assert.IsType<ResponseWrapper<Recipe>>(okResult.Value); // Extract the ResponseWrapper object and assert its type
			var actualRecipe = responseWrapper.Data; // Extract the Recipe object from the ResponseWrapper

			Assert.Equal(expectedRecipe, actualRecipe); // Optionally, assert more details as needed
		}


		[Fact]
		public async Task GenerateRecipe_Returns_BadRequest_OnException()
		{
			// Arrange
			var mockService = new Mock<IRecipeService>();
			var controller = new RecipeController(mockService.Object);
			var ingredientIds = new List<int> { 1, 2, 3 }; // Provide sample ingredient ids

			mockService.Setup(x => x.GenerateRecipeAsync(It.IsAny<List<Ingredient>>())).ThrowsAsync(new Exception());

			// Act
			var result = await controller.GenerateRecipe(ingredientIds);

			// Assert
			Assert.IsType<BadRequestObjectResult>(result); // Assert it's a BadRequestObjectResult
		}

		[Fact]
		public async Task AddRecipeToFavourite_Returns_OkResult()
		{
			// Arrange
			var mockService = new Mock<IRecipeService>();
			var controller = new RecipeController(mockService.Object);
			var userId = 1;
			var recipeId = 1;

			// Act
			var result = await controller.AddRecipeToFavourite(userId, recipeId);

			// Assert
			Assert.IsType<OkObjectResult>(result); // Assert it's an OkObjectResult

			var okResult = result as OkObjectResult;
			Assert.IsType<ResponseWrapper<bool>>(okResult.Value); // Assert the response type
		}

		[Fact]
		public async Task AddRecipeToFavourite_Returns_BadRequest_OnException()
		{
			// Arrange
			var mockService = new Mock<IRecipeService>();
			var controller = new RecipeController(mockService.Object);
			var userId = 1;
			var recipeId = 1;

			mockService.Setup(x => x.AddRecipeToFavouriteAsync(userId, recipeId)).ThrowsAsync(new Exception());

			// Act
			var result = await controller.AddRecipeToFavourite(userId, recipeId);

			// Assert
			Assert.IsType<BadRequestObjectResult>(result); // Assert it's a BadRequestObjectResult
		}

		// Similar tests can be written for GetAllFavouriteRecipes and DeleteFavouriteRecipe following the same pattern

		[Fact]
		public async Task GetIngredients_Returns_OkObjectResult_WithIngredients()
		{
			// Arrange
			var mockService = new Mock<IRecipeService>();
			var controller = new RecipeController(mockService.Object);
			var categoryId = FoodCategory.GrainsAndCereals; // Assuming FoodCategory is an enum

			var expectedIngredients = new List<Ingredient>();
			mockService.Setup(x => x.GetAllIngredientsAsync(categoryId)).ReturnsAsync(expectedIngredients);

			// Act
			var result = await controller.GetIngredients(categoryId);

			// Assert
			var okResult = Assert.IsType<OkObjectResult>(result); // Assert it's an OkObjectResult

			var responseWrapper = Assert.IsType<ResponseWrapper<IEnumerable<Ingredient>>>(okResult.Value); // Extract the ResponseWrapper object and assert its type
			var actualIngredients = responseWrapper.Data; // Extract the ingredient list from the ResponseWrapper

			Assert.Equal(expectedIngredients, actualIngredients); // Optionally, assert more details as needed
		}



		[Fact]
		public async Task RegisterUser_Returns_OkResult()
		{
			// Arrange
			var mockService = new Mock<IUserService>();
			var controller = new UserController(mockService.Object);
			var user = new UserRegisterDTO();

			// Act
			var result = await controller.RegisterUser(user);

			// Assert
			Assert.IsType<OkObjectResult>(result); // Assert it's an OkObjectResult

			var okResult = result as OkObjectResult;
			Assert.IsType<ResponseWrapper<bool>>(okResult.Value); // Assert the response type
		}

		[Fact]
		public async Task RegisterUser_Returns_BadRequest_OnException()
		{
			// Arrange
			var mockService = new Mock<IUserService>();
			var controller = new UserController(mockService.Object);
			var user = new UserRegisterDTO();

			mockService.Setup(x => x.RegisterUserAsync(user)).ThrowsAsync(new Exception());

			// Act
			var result = await controller.RegisterUser(user);

			// Assert
			Assert.IsType<BadRequestObjectResult>(result); // Assert it's a BadRequestObjectResult
		}

		[Fact]
		public async Task LoginUser_Returns_OkObjectResult_WithUser_OnSuccess()
		{
			// Arrange
			var mockService = new Mock<IUserService>();
			var controller = new UserController(mockService.Object);
			var user = new User { Username = "username", Password = "password" };
			var userLoginDTO = new UserLoginDTO { Username = user.Username, Password = user.Password };

			var expectedUser = new User { Username = "username", Password = "password" };
			mockService.Setup(x => x.LoginUserAsync(user.Username, user.Password)).ReturnsAsync(expectedUser);

			// Act
			var result = await controller.LoginUser(userLoginDTO);

			// Assert
			var okResult = Assert.IsType<OkObjectResult>(result); // Assert it's an OkObjectResult

			var responseWrapper = Assert.IsType<ResponseWrapper<User>>(okResult.Value); // Extract the ResponseWrapper object and assert its type
			var actualUser = responseWrapper.Data; // Extract the User object from the ResponseWrapper

			Assert.Equal(expectedUser.Username, actualUser.Username); // Optionally, assert more details as needed
			Assert.Equal(expectedUser.Password, actualUser.Password); // Only assert password if hashing is not used
		}


		[Fact]
		public async Task LoginUser_Returns_Unauthorized_OnInvalidCredentials()
		{
			// Arrange
			var mockService = new Mock<IUserService>();
			var controller = new UserController(mockService.Object);
			var user = new User { Username = "username", Password = "password" };
			var userLoginDTO = new UserLoginDTO { Username = user.Username, Password = user.Password };

			mockService.Setup(x => x.LoginUserAsync(user.Username, user.Password)).ReturnsAsync(null as User);

			// Act
			var result = await controller.LoginUser(userLoginDTO);

			// Assert
			Assert.IsType<UnauthorizedObjectResult>(result); // Assert it's an UnauthorizedObjectResult
		}

		[Fact]
		public async Task LoginUser_Returns_BadRequest_OnException()
		{
			// Arrange
			var mockService = new Mock<IUserService>();
			var controller = new UserController(mockService.Object);
			var user = new User { Username = "username", Password = "password" };
			var userLoginDTO = new UserLoginDTO { Username = user.Username, Password = user.Password };

			mockService.Setup(x => x.LoginUserAsync(user.Username, user.Password)).ThrowsAsync(new Exception());

			// Act
			var result = await controller.LoginUser(userLoginDTO);

			// Assert
			Assert.IsType<BadRequestObjectResult>(result); // Assert it's a BadRequestObjectResult
		}
	}
}
