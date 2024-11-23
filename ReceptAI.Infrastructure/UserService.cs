using ReceptAI.Core.Interfaces;
using ReceptAI.Core.Models;
using ReceptAI.Core.DTOs;

namespace ReceptAI.Infrastructure
{
    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;

        public UserService(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public async Task<User> LoginUserAsync(string username, string password)
        {
            return await _userRepository.LoginUserAsync(username, password);
        }

        public async Task RegisterUserAsync(UserRegisterDTO user)
        {
           await _userRepository.RegisterUserAsync(user);
        }
    }
}
