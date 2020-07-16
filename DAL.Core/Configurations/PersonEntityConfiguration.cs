﻿using DAL.Core.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace DAL.Core.Configurations
{
	public class PersonEntityConfiguration : IEntityTypeConfiguration<PersonEntity>
	{
		public void Configure(EntityTypeBuilder<PersonEntity> builder)
		{
			builder.ToTable(PersonEntity.TableName);
			builder.HasKey(t => t.PersonId);
			builder.Property(t => t.PersonUid);
			builder.Property(t => t.Name);
			builder.Property(t => t.Agenda);
			builder.Property(t => t.Age); 
			builder.Property(t => t.PersonImageContentId);
			builder.HasOne(t => t.PersonImageContentEntity).WithMany().HasForeignKey(x => x.PersonImageContentId);
			builder.HasMany(t => t.FriendList).WithOne().HasForeignKey(x => x.PersonId);
			builder.HasMany(t => t.ChatList).WithOne().HasForeignKey(x => x.PersonId);
		}
	}
}