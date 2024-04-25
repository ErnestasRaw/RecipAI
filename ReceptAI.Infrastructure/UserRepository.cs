using Microsoft.EntityFrameworkCore;
using ReceptAI.Core.Interfaces;
using ReceptAI.Core.Models;

namespace ReceptAI.Infrastructure
{
    public class UserRepository : IUserRepository
    {
        private readonly AppDbContext _context;

        public UserRepository(AppDbContext context)
        {
            _context = context;
        }
        public async Task<User> LoginUserAsync(string username, string password)
        {
            return await _context.Users.FirstOrDefaultAsync(u => u.Username == username && u.Password == password);
        }

        public async Task RegisterUserAsync(User user)
        {
			bool userExists = await _context.Users.AnyAsync(u => u.Username == user.Username || u.Email == user.Email);
			if (userExists)
			{
				throw new InvalidOperationException("User with the same username or email already exists.");
			}

			await _context.Users.AddAsync(user);
			await _context.SaveChangesAsync();
		}
    }
}
