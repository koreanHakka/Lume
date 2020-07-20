﻿using DAL.Core.Entities;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace DAL.Core.Interfaces
{
	public interface IImageRepository
	{
		Task<bool> CheckPersonImageExistence(Guid uid, CancellationToken cancellationToken = default);
		Task<Guid?> GetPersonImageUidByHash(string hash);
		Task SavePersonImage(Guid personUid, PersonImageContentEntity entity);
		Task<byte[]> GetPersonImageContentByUid(Guid uid);

		Task<bool> CheckEventImageExistence(Guid uid, CancellationToken cancellationToken = default);
		Task<Guid?> GetEventImageUidByHash(string hash);
		Task SaveEventImage(Guid eventUid, EventImageContentEntity entity);
		Task<byte[]> GetEventImageContentByUid(Guid uid);

		Task<bool> CheckChatMessageImageExistence(Guid uid, CancellationToken cancellationToken = default);
	}
}