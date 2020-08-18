﻿using System.Collections.Generic;

namespace Constants
{
    public static class AuthProtectedRoutes
    {
        public static readonly List<string> ProtectedRoutes = new List<string>
        {
             "/home/secure",

             "/api/person/get-profile",
             "/api/person/get-person",
             "/api/person/update-person",
             "/api/person/is-person-filled-up",
             "/api/person/get-person-list",
             "/api/person/get-random-person",
             "/api/person/accept-random-person",
             "/api/person/reject-random-person",
             "/api/person/get-person-notifications",
             "/api/person/remove-person-token",
             "/api/person/add-feedback",

             "/api/event/add-event",
             "/api/event/get-event",
             "/api/event/get-event-list",
             "/api/event/update-event",
             "/api/event/add-event-participant",
             "/api/event/update-event-participant",
             "/api/event/remove-event-participant",
             "/api/event/get-random-event",
             "/api/evemt/search-for-event",
             "/api/evemt/accept-random-event",
             "/api/evemt/reject-random-event",

             "/api/friends/add-friend",
             "/api/friends/remove-friend",
             "​/api​/friends​/get-friends",
             "​/api​/friends​/confirm-friend",

             "/api/chat/get-chat",
             "/api/chat/get-person-chat",
             "/api/chat/get-person-chat-list",
             "/api/chat/add-chat-message",
             "/api/chat/get-new-chat-messages",

             "/api/city/get-cities",

             "/api/contacts/get-person-list-by-contacts"
        };
    }
}