﻿using BLL.Core.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Threading.Tasks;

namespace LumeWebApp.Controllers
{
	[Route("api/image")]
	[ApiController]
	public class ImageController : ControllerBase
	{
		private readonly IImageValidation _imageValidation;
		private readonly IImageLogic _imageLogic;

		public ImageController(IImageValidation imageValidation,
			IImageLogic imageLogic)
		{
			_imageValidation = imageValidation;
			_imageLogic = imageLogic;
		}

		[HttpGet]
		[Route("get-image")]
		public async Task<ActionResult> GetImage(Guid imageUid)
		{
			var validationResult = _imageValidation.ValidateGetImage(imageUid);
			if (!validationResult.ValidationResult)
			{
				return BadRequest(validationResult.ValidationMessage);
			}
			var content = await _imageLogic.GetImage(imageUid);
			return File(content, "image/jpeg");
		}

		[HttpGet]
		[Route("get-miniature-image")]
		public async Task<ActionResult> GetMiniatureImage(Guid imageUid)
		{
			var validationResult = _imageValidation.ValidateGetMiniatureImage(imageUid);
			if (!validationResult.ValidationResult)
			{
				return BadRequest(validationResult.ValidationMessage);
			}
			var content = await _imageLogic.GetMiniatureImage(imageUid);
			return File(content, "image/jpeg");
		}
	}
}
