﻿using System;

namespace BLL.Authorization.Models
{
	public class AuthorizationPersonModel
	{
		public Guid PersonUid { get; set; }
		public string PhoneNumber { get; set; }
		public string Code { get; set; }
		public string RefreshToken { get; set; }
	}
}