using Microsoft.AspNetCore.Mvc;
using ReceptAI.Core.Interfaces;
using ReceptAI.Core.Models;
using Swashbuckle.AspNetCore.Annotations;
using ReceptAI.Core.DTOs;

namespace ReceptAI.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UserController : ControllerBase
    {
        private readonly IUserService _userService;

        public UserController(IUserService userService)
        {
            _userService = userService;
        }

        [HttpPost("RegisterUser")]
        [SwaggerOperation(Summary = "Registers a new user", Description = "Creates a new user account with the provided details", OperationId = "RegisterUser")]
		public async Task<IActionResult> RegisterUser([FromBody] UserRegisterDTO user)
		{
			try
			{
				await _userService.RegisterUserAsync(user);
				return Ok(new ResponseWrapper<bool>(true));
			}
			catch (Exception ex)
			{
				return BadRequest(new ResponseWrapper<bool>(false, false));
			}
		}

		[HttpPost("LoginUser")]
        [SwaggerOperation(Summary = "Authenticates a user", Description = "Authenticates the user with the provided name and password", OperationId = "LoginUser")]
		public async Task<IActionResult> LoginUser([FromBody] UserLoginDTO user)
		{
			try
			{
				var userFromDb = await _userService.LoginUserAsync(user.Username, user.Password);
				if (userFromDb == null)
				{
					return Unauthorized(new ResponseWrapper<User>(null, false));
				}
				return Ok(new ResponseWrapper<User>(userFromDb));
			}
			catch (Exception ex)
			{
				return BadRequest(new ResponseWrapper<User>(null, false));
			}
		}
	}
}
