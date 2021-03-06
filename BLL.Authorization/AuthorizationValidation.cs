﻿using BLL.Authorization.Interfaces;
using BLL.Authorization.Models;
using BLL.Core;
using Constants;
using DAL.Authorization;
using DAL.Core.Interfaces;
using Microsoft.AspNetCore.Http;
using System;
using System.Text.RegularExpressions;

namespace BLL.Authorization
{
	public class AuthorizationValidation : BaseValidator, IAuthorizationValidation
	{
		private readonly IAuthorizationRepository _authorizationRepository;
		private readonly IPersonRepository _personRepository;
		public AuthorizationValidation(IHttpContextAccessor contextAccessor, 
			IAuthorizationRepository authorizationRepository,
			IPersonRepository personRepository) : base(contextAccessor)
		{
			_authorizationRepository = authorizationRepository;
			_personRepository = personRepository;
		}

		public (bool ValidationResult, string ValidationMessage) ValidateGetCode(string phoneNumber)
		{
			if (string.IsNullOrWhiteSpace(phoneNumber))
			{
				return (false, ErrorDictionary.GetErrorMessage(6, _culture));
			}
			else if (!Regex.Match(phoneNumber, RegexTemplates.PhoneTemplate).Success)
			{
				return (false, ErrorDictionary.GetErrorMessage(6, _culture));
			}
			var person = _authorizationRepository.GetPerson(phoneNumber).Result;
			if (person != null && person.TemporaryCodeTime.HasValue)
			{
				var timeDifference = (DateTime.UtcNow - person.TemporaryCodeTime.Value).TotalSeconds;
				if (timeDifference < 30)
				{
					return (false, ErrorDictionary.GetErrorMessage(45, _culture));
				}
			}
			return (true, string.Empty);
		}

		public (bool ValidationResult, string ValidationMessage) ValidateSetCode(AuthorizationPersonModel person, string code)
		{
			if (string.IsNullOrWhiteSpace(code))
			{
				return (false, ErrorDictionary.GetErrorMessage(7, _culture));
			}
			else if (!Regex.Match(code, RegexTemplates.AuthorizationCodeTemplate).Success)
			{
				return (false, ErrorDictionary.GetErrorMessage(7, _culture));
			}

			if (person == null)
			{
				return (false, ErrorDictionary.GetErrorMessage(2, _culture));
			}
			else if (person.Code != code)
			{
				return (false, ErrorDictionary.GetErrorMessage(3, _culture));
			}

			return (true, string.Empty);
		}

		public (bool ValidationResult, string ValidationMessage) ValidateGetAccessToken(AuthorizationPersonModel person, string refreshToken)
		{
			if (string.IsNullOrWhiteSpace(refreshToken))
			{
				return (false, ErrorDictionary.GetErrorMessage(8, _culture));
			}
			if (person == null)
			{
				return (false, ErrorDictionary.GetErrorMessage(2, _culture));
			}
			if (person.RefreshToken != refreshToken)
			{
				return (false, ErrorDictionary.GetErrorMessage(4, _culture));
			}

			return (true, string.Empty);
		}

		public (bool ValidationResult, string ValidationMessage) ValidateGetPushCode(string phoneNumber, string token)
		{
			if (string.IsNullOrWhiteSpace(phoneNumber))
			{
				return (false, ErrorDictionary.GetErrorMessage(6, _culture));
			}
			else if (!Regex.Match(phoneNumber, RegexTemplates.PhoneTemplate).Success)
			{
				return (false, ErrorDictionary.GetErrorMessage(6, _culture));
			}
			if (string.IsNullOrWhiteSpace(token))
			{
				return (false, ErrorDictionary.GetErrorMessage(38, _culture));
			}
			var authPerson = _authorizationRepository.GetPerson(phoneNumber).Result;
			var corePerson = _personRepository.GetPersonByToken(token).Result;
			if (authPerson == null || corePerson == null || authPerson.PersonUid != corePerson.PersonUid)
			{
				return (false, ErrorDictionary.GetErrorMessage(41, _culture));
			}
			return (true, string.Empty);
		}
	}
}
