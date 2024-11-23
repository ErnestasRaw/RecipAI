using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace ReceptAI.Core.Models
{
	public class User
	{
		public int UserId { get; set; }

		[Required]
		public string Username { get; set; }

		[Required, EmailAddress]
		public string Email { get; set; }

		[JsonIgnore, Required]
		public string Password { get; set; }
	}

	

    

}
