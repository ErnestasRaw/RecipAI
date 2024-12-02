﻿using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace ReceptAI.Core.Models
{
	public class User
	{
		public int UserId { get; set; }

		[Required(ErrorMessage = "Username is required.")]
		[MaxLength(50, ErrorMessage = "Username cannot exceed 50 characters.")]
		public string Username { get; set; }

		[Required(ErrorMessage = "Email is required.")]
		[EmailAddress(ErrorMessage = "Invalid email format.")]
		public string Email { get; set; }

		[JsonIgnore]
		[Required(ErrorMessage = "Password is required.")]
		[MinLength(6, ErrorMessage = "Password must be at least 6 characters long.")]
		public string Password { get; set; }
	}
}