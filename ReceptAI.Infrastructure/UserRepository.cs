using Microsoft.EntityFrameworkCore;
using ReceptAI.Core.DTOs;
using ReceptAI.Core.Interfaces;
using ReceptAI.Core.Models;

namespace ReceptAI.Infrastructure
{
	public class UserRepository : IUserRepository
	{
		private readonly AppDbContext _context;

		private const string UsernamePasswordNullOrEmptyError = "Username and password cannot be null or empty.";
		private const string UserExistsError = "User with the same username or email already exists.";

		public UserRepository(AppDbContext context)
		{
			_context = context;
		}

		public async Task<User> LoginUserAsync(string username, string password)
		{
			ValidateCredentials(username, password);

			var user = await _context.Users.FirstOrDefaultAsync(u => u.Username == username && u.Password == password);
			if (user == null)
			{
				throw new InvalidOperationException("Invalid username or password.");
			}

			return user;
		}

		private void ValidateCredentials(string username, string password)
		{
			if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
			{
				throw new ArgumentException(UsernamePasswordNullOrEmptyError);
			}
		}

		public async Task RegisterUserAsync(UserRegisterDTO user)
		{
			if (user == null)
			{
				throw new ArgumentNullException(nameof(user));
			}

			await CheckIfUserExistsAsync(user);

			var newUser = new User
			{
				Username = user.Username,
				Email = user.Email,
				Password = user.Password
			};

			try
			{
				await _context.Users.AddAsync(newUser);
				await _context.SaveChangesAsync();
			}
			catch (DbUpdateException)
			{
				throw new InvalidOperationException(UserExistsError);
			}
		}

		private async Task CheckIfUserExistsAsync(UserRegisterDTO user)
		{
			bool userExists = await _context.Users.AnyAsync(u => u.Username == user.Username || u.Email == user.Email);
			if (userExists)
			{
				throw new InvalidOperationException(UserExistsError);
			}
		}
	}
}
