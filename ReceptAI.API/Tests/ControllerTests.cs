using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Moq;
using Xunit;
using ReceptAI.Controllers;
using ReceptAI.Core.Interfaces;
using ReceptAI.Core.Models;
using ReceptAI.Infrastructure;
using Rystem.OpenAi;
using ReceptAI.API.Controllers;
using ReceptAI.Core.DTOs;

namespace ReceptAI.Tests
{
    public class ControllerTests
    {
		[Fact]
		public async Task GenerateRecipe_Returns_OkObjectResult_WithRecipe()
		{
			// Arrange
			var mockService = new Mock<IRecipeService>();
			var controller = new RecipeController(mockService.Object);
			var ingredientIds = new List<int>();

			var expectedRecipe = new Recipe();
			var ingredients = new List<Ingredient>();

			mockService.Setup(x => x.GetIngredientsByIdsAsync(ingredientIds)).ReturnsAsync(ingredients);
			mockService.Setup(x => x.GenerateRecipeAsync(ingredients)).ReturnsAsync(expectedRecipe);

			// Act
			var result = await controller.GenerateRecipe(ingredientIds);

			// Assert
			var okResult = Assert.IsType<OkObjectResult>(result);

			var responseWrapper = Assert.IsType<ResponseWrapper<Recipe>>(okResult.Value);
			var actualRecipe = responseWrapper.Data;

			Assert.Equal(expectedRecipe, actualRecipe);
		}


		[Fact]
		public async Task GenerateRecipe_Returns_BadRequest_OnException()
		{
			// Arrange
			var mockService = new Mock<IRecipeService>();
			var controller = new RecipeController(mockService.Object);
			var ingredientIds = new List<int> { 1, 2, 3 };

			mockService.Setup(x => x.GenerateRecipeAsync(It.IsAny<List<Ingredient>>())).ThrowsAsync(new Exception());

			// Act
			var result = await controller.GenerateRecipe(ingredientIds);

			// Assert
			Assert.IsType<BadRequestObjectResult>(result);
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
			Assert.IsType<OkObjectResult>(result);

			var okResult = result as OkObjectResult;
			Assert.IsType<ResponseWrapper<bool>>(okResult.Value);
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
			Assert.IsType<BadRequestObjectResult>(result);
		}

		[Fact]
		public async Task GetIngredients_Returns_OkObjectResult_WithIngredients()
		{
			// Arrange
			var mockService = new Mock<IRecipeService>();
			var controller = new RecipeController(mockService.Object);
			var categoryId = FoodCategory.GrainsAndCereals;

			var expectedIngredients = new List<Ingredient>();
			mockService.Setup(x => x.GetAllIngredientsAsync(categoryId)).ReturnsAsync(expectedIngredients);

			// Act
			var result = await controller.GetIngredients(categoryId);

			// Assert
			var okResult = Assert.IsType<OkObjectResult>(result);

			var responseWrapper = Assert.IsType<ResponseWrapper<IEnumerable<Ingredient>>>(okResult.Value);
			var actualIngredients = responseWrapper.Data;

			Assert.Equal(expectedIngredients, actualIngredients);
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

		[Fact]
		public async Task GetAllFavouriteRecipes_Returns_OkObjectResult_WithRecipes()
		{
			// Arrange
			var mockService = new Mock<IRecipeService>();
			var controller = new RecipeController(mockService.Object);
			var userId = 1;

			var expectedRecipes = new List<Recipe>();
			mockService.Setup(x => x.GetAllFavouriteRecipesAsync(userId)).ReturnsAsync(expectedRecipes);

			// Act
			var result = await controller.GetAllFavouriteRecipes(userId);

			// Assert
			var okResult = Assert.IsType<OkObjectResult>(result); // Assert it's an OkObjectResult

			var responseWrapper = Assert.IsType<ResponseWrapper<IEnumerable<Recipe>>>(okResult.Value); // Extract the ResponseWrapper object and assert its type
			var actualRecipes = responseWrapper.Data; // Extract the Recipe list from the ResponseWrapper

			Assert.Equal(expectedRecipes, actualRecipes); // Optionally, assert more details as needed
		}

		[Fact]
		public async Task GetAllFavouriteRecipes_Returns_BadRequest_OnException()
		{
			// Arrange
			var mockService = new Mock<IRecipeService>();
			var controller = new RecipeController(mockService.Object);
			var userId = 1;

			mockService.Setup(x => x.GetAllFavouriteRecipesAsync(userId)).ThrowsAsync(new Exception());

			// Act
			var result = await controller.GetAllFavouriteRecipes(userId);

			// Assert
			Assert.IsType<BadRequestObjectResult>(result); // Assert it's a BadRequestObjectResult
		}
	}
}
