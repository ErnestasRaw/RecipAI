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
		public async Task GenerateRecipe_Returns_Recipe()
		{
			// Arrange
			var mockService = new Mock<IRecipeService>();
			var controller = new RecipeController(mockService.Object);
			var ingredients = new List<Ingredient>();

			var expectedRecipe = new Recipe(); // Assume your service method returns a Recipe object
			mockService.Setup(x => x.GenerateRecipeAsync(ingredients)).ReturnsAsync(expectedRecipe);

			// Act
			var result = await controller.GenerateRecipe(ingredients);

			// Assert
			Assert.IsType<Recipe>(result); // Change the type to Recipe to match the actual returned type
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
			Assert.IsType<OkResult>(result);
		}

		[Fact]
		public async Task GetAllFavouriteRecipes_Returns_Recipes()
		{
			// Arrange
			var mockService = new Mock<IRecipeService>();
			var controller = new RecipeController(mockService.Object);
			var userId = 1;

			// Assume your service method returns a list of Recipe objects
			var expectedRecipes = new List<Recipe>();
			mockService.Setup(x => x.GetAllFavouriteRecipesAsync(userId)).ReturnsAsync(expectedRecipes);

			// Act
			var result = await controller.GetAllFavouriteRecipes(userId);

			// Assert
			var actionResult = Assert.IsType<ActionResult<IEnumerable<Recipe>>>(result);
			Assert.Equal(expectedRecipes, actionResult.Value);
		}

		[Fact]
		public async Task DeleteFavouriteRecipe_Returns_OkResult()
		{
			// Arrange
			var mockService = new Mock<IRecipeService>();
			var controller = new RecipeController(mockService.Object);
			var recipeId = 1;

			// Act
			var result = await controller.DeleteFavouriteRecipe(recipeId);

			// Assert
			Assert.IsType<OkResult>(result);
		}

		[Fact]
		public async Task GetIngredients_Returns_Ingredients()
		{
			// Arrange
			var mockService = new Mock<IRecipeService>();
			var controller = new RecipeController(mockService.Object);
			var categoryId = FoodCategory.GrainsAndCereals; // assuming FoodCategory is an enum

			// Assume your service method returns a list of Ingredient objects
			var expectedIngredients = new List<Ingredient>();
			mockService.Setup(x => x.GetAllIngredientsAsync(categoryId)).ReturnsAsync(expectedIngredients);

			// Act
			var result = await controller.GetIngredients(categoryId);

			// Assert
			var actionResult = Assert.IsType<ActionResult<IEnumerable<Ingredient>>>(result);
			Assert.Equal(expectedIngredients, actionResult.Value);
		}

		[Fact]
		public async Task RegisterUser_Returns_OkResult()
		{
			// Arrange
			var mockService = new Mock<IUserService>();
			var controller = new UserController(mockService.Object);
			var user = new User();

			// Act
			var result = await controller.RegisterUser(user);

			// Assert
			Assert.IsType<OkResult>(result);
		}

		[Fact]
		public async Task LoginUser_Returns_User_If_Authenticated()
		{
			// Arrange
			var mockService = new Mock<IUserService>();
			var controller = new UserController(mockService.Object);
			var user = new User { Username = "username", Password = "password" };

			// Assume your service method returns a User object if authenticated
			var expectedUser = new User { Username = "username", Password = "password" };
			mockService.Setup(x => x.LoginUserAsync(user.Username, user.Password)).ReturnsAsync(expectedUser);

			// Act
			var result = await controller.LoginUser(user);

			// Assert
			var actionResult = Assert.IsType<ActionResult<User>>(result);
			Assert.Equal(expectedUser, actionResult.Value);
		}

		[Fact]
		public async Task LoginUser_Returns_Unauthorized_If_Not_Authenticated()
		{
			// Arrange
			var mockService = new Mock<IUserService>();
			var controller = new UserController(mockService.Object);
			var user = new User { Username = "username", Password = "password" };

			// Assume your service method returns null if not authenticated
			mockService.Setup(x => x.LoginUserAsync(user.Username, user.Password)).ReturnsAsync(null as User);

			// Act
			var result = await controller.LoginUser(user);

			// Assert
			Assert.IsType<UnauthorizedResult>(result);
		}
	}
}
