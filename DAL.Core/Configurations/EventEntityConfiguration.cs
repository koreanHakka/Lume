﻿using DAL.Core.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace DAL.Core.Configurations
{
	public class EventEntityConfiguration : IEntityTypeConfiguration<EventEntity>
	{
		public void Configure(EntityTypeBuilder<EventEntity> builder)
		{
			builder.ToTable(EventEntity.TableName);
			builder.HasKey(t => t.EventId);
			builder.Property(t => t.Name);
			builder.Property(t => t.MinAge);
			builder.Property(t => t.MaxAge);
			builder.Property(t => t.XCoordinate);
			builder.Property(t => t.YCoordinate);
			builder.Property(t => t.Agenda);
			builder.Property(t => t.StartTime);
			builder.Property(t => t.EndTime);
			builder.Property(t => t.EventImageContentId);
			builder.Property(t => t.EventTypeId);
			builder.Property(t => t.EventStatusId);
			builder.Property(t => t.AdministratorId);
			builder.HasOne(t => t.EventImageContent).WithMany().HasForeignKey(x => x.EventImageContentId);
			builder.HasOne(t => t.EventType).WithMany().HasForeignKey(x => x.EventTypeId);
			builder.HasOne(t => t.EventStatus).WithMany().HasForeignKey(x => x.EventStatusId);
			builder.HasOne(t => t.Administrator).WithMany().HasForeignKey(x => x.AdministratorId);
		}
	}
}
