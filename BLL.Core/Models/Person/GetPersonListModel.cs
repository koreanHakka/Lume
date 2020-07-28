﻿using System;

namespace BLL.Core.Models.Person
{
	public class GetPersonListFilter
	{
		public int PageNumber { get; set; }
		public int PageSize { get; set; }
		public string Query { get; set; }
		public long? CityId { get; set; }
	}
}