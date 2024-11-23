using ReceptAI.Core.Models;
using ReceptAI.Core.DTOs;

namespace ReceptAI.Core.Interfaces
{
    public interface IUserService
    {
        Task RegisterUserAsync(UserRegisterDTO user);
        Task<User> LoginUserAsync(string username, string password);
    }
}
