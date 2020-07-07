﻿// <auto-generated />
using System;
using DAL.Authorization;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace DAL.Authorization.Migrations
{
    [DbContext(typeof(AuthorizationDbContext))]
    partial class AuthorizationDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "3.1.5")
                .HasAnnotation("Relational:MaxIdentifierLength", 128)
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("DAL.Authorization.Entities.UserAuthEntity", b =>
                {
                    b.Property<int>("UserId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("AccessKey")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("ExpirationTime")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("RefreshKey")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("TemporaryCode")
                        .HasColumnType("nvarchar(max)");

                    b.Property<Guid>("UserUid")
                        .HasColumnType("uniqueidentifier");

                    b.HasKey("UserId");

                    b.ToTable("UserAuthEntities");
                });
#pragma warning restore 612, 618
        }
    }
}
