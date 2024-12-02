﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ReceptAI.Core.DTOs
{
	public class UserRegisterDTO
	{
		[Required(ErrorMessage = "Username is required.")]
		[MaxLength(50, ErrorMessage = "Username cannot exceed 50 characters.")]
		public string Username { get; set; }

		[Required(ErrorMessage = "Email is required.")]
		[EmailAddress(ErrorMessage = "Invalid email format.")]
		public string Email { get; set; }

		[Required(ErrorMessage = "Password is required.")]
		[MinLength(6, ErrorMessage = "Password must be at least 6 characters long.")]
		public string Password { get; set; }
	}
}
