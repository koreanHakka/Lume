﻿using System;

namespace BLL.Core.Models.Chat
{
	public class ChatListModel
	{
		public Guid ChatUid { get; set; }
		public bool IsGroupChat { get; set; }
		public ChatMessageModel LastMessage { get; set; }
	}
}