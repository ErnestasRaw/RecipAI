using Microsoft.EntityFrameworkCore;
using ReceptAI.Core.Interfaces;
using ReceptAI.Core.Models;
using ReceptAI.Core.DTOs;

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
			if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
			{
				throw new ArgumentException("Username and password cannot be null or empty.");
			}

			return await _context.Users.FirstOrDefaultAsync(u => u.Username == username && u.Password == password);
        }

        public async Task RegisterUserAsync(UserRegisterDTO user)
        {
			if (user == null)
			{
				throw new ArgumentNullException(nameof(user));
			}

			var newUser = new User
			{
				Username = user.Username,
				Email = user.Email,
				Password = user.Password
			};

			bool userExists = await _context.Users.AnyAsync(u => u.Username == newUser.Username || u.Email == newUser.Email);
			if (userExists)
			{
				throw new InvalidOperationException("User with the same username or email already exists.");
			}

			await _context.Users.AddAsync(newUser);
			await _context.SaveChangesAsync();
		}
    }
}
