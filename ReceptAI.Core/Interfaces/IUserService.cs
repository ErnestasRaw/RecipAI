using ReceptAI.Core.Models;

namespace ReceptAI.Core.Interfaces
{
    public interface IUserService
    {
        Task RegisterUserAsync(User user);
        Task<User> LoginUserAsync(string username, string password);
    }
}
