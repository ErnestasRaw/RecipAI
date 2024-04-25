using System.Text.Json.Serialization;

namespace ReceptAI.Core.Models
{
	public class User
	{
		[JsonIgnore]
		public int UserId { get; set; }
		public string Username { get; set; }
		public string Email { get; set; }
		public string Password { get; set; }


	}

	public class UserLoginDTO
	{
		public string Username { get; set; }
		public string Password { get; set; }
	}

}
