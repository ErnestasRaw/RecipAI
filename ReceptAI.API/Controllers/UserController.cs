using Microsoft.AspNetCore.Mvc;
using ReceptAI.Core.Interfaces;
using ReceptAI.Core.Models;
using Swashbuckle.AspNetCore.Annotations;

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
        public async Task<IActionResult> RegisterUser([FromBody] User user)
        {
            await _userService.RegisterUserAsync(user);
            return Ok();
        }

        [HttpPost("LoginUser")]
        [SwaggerOperation(Summary = "Authenticates a user", Description = "Authenticates the user with the provided name and password", OperationId = "LoginUser")]
        public async Task<IActionResult> LoginUser([FromBody] User user)
        {
            var userFromDb = await _userService.LoginUserAsync(user.Username, user.Password);
            if (userFromDb == null)
            {
                return Unauthorized();
            }
            return Ok(userFromDb);
        }
    }
}
