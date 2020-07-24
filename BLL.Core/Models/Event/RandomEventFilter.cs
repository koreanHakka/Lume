﻿using System;
using System.Collections.Generic;

namespace BLL.Core.Models.Event
{
	public class RandomEventFilter
	{
		public List<Guid> IgnoredEventUids { get; set; }
		public int Age { get; set; }
		public double? PersonXCoordinate { get; set; }
		public double? PersonYCoordinate { get; set; }
		public double? Distance { get; set; }
	}
}