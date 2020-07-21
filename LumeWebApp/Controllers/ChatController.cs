﻿using BLL.Core.Interfaces;
using BLL.Core.Models.Chat;
using Constants;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace LumeWebApp.Controllers
{
	[Route("api/chat")]
	[ApiController]
	public class ChatController : ControllerBase
	{
		private readonly IChatValidation _chatValidation;
		private readonly IChatLogic _chatLogic;

		public ChatController(IChatValidation chatValidation,
			IChatLogic chatLogic)
		{
			_chatValidation = chatValidation;
			_chatLogic = chatLogic;
		}


		[HttpGet]
		[Route("get-chat")]
		public async Task<ActionResult<ChatModel>> GetChat(Guid chatUid) 
		{
			var validationResult = _chatValidation.ValidateGetChat(chatUid);
			if (!validationResult.ValidationResult)
			{
				return BadRequest(validationResult.ValidationMessage);
			}
			return await _chatLogic.GetChat(chatUid);
		}

		[HttpGet]
		[Route("get-person-chat")]
		public async Task<ActionResult<ChatModel>> GetPersonChat(Guid personUid)
		{
			var uid = new Guid(HttpContext.Request.Headers[AuthorizationHeaders.PersonUid].First());
			var validationResult = _chatValidation.ValidateGetPersonChat(personUid);
			if (!validationResult.ValidationResult)
			{
				return BadRequest(validationResult.ValidationMessage);
			}
			return await _chatLogic.GetPersonChat(uid, personUid);
		}
	}
}
