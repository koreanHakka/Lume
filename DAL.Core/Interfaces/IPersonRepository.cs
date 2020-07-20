﻿using DAL.Core.Entities;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace DAL.Core.Interfaces
{
	public interface IPersonRepository
	{
		Task<PersonEntity> GetPerson(Guid uid, CancellationToken cancellationToken = default);
		Task CreatePerson(Guid personUid, CancellationToken cancellationToken = default);
		Task UpdatePerson(PersonEntity person, CancellationToken cancellationToken = default);
		Task<bool> CheckPersonExistence(Guid personUid, CancellationToken cancellationToken = default);
	}
}