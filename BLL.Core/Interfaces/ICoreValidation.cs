﻿using BLL.Core.Models;

namespace BLL.Core.Interfaces
{
	public interface ICoreValidation
	{
		(bool ValidationResult, string ValidationMessage) ValidateUpdatePerson(UpdatePersonModel model);
	}
}