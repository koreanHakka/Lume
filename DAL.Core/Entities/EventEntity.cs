﻿using System;
using System.Collections.Generic;

namespace DAL.Core.Entities
{
	public class EventEntity
	{
		public const string TableName = "Event";
		public long EventId { get; set; }
		public Guid EventUid { get; set; }
		public string Name { get; set; }
		public byte? MinAge { get; set; }
		public byte? MaxAge { get; set; }
		public double XCoordinate { get; set; }
		public double YCoordinate { get; set; }
		public string Description { get; set; }
		public DateTime? StartTime { get; set; }
		public DateTime? EndTime { get; set; }
		public bool? IsOpenForInvitations { get; set; }
		public long? EventImageContentId { get; set; }
		public long EventTypeId { get; set; }
		public long EventStatusId { get; set; }
		public long AdministratorId { get; set; }
		public long ChatId { get; set; }
		public EventImageContentEntity EventImageContent { get; set; }
		public EventStatusEntity EventStatus { get; set; }
		public EventTypeEntity EventType { get; set; }
		public PersonEntity Administrator { get; set; }
		public ChatEntity Chat { get; set; }
		public IEnumerable<PersonToEventEntity> Participants { get; set; }
	}
}