using System;
using System.Collections.Generic;
using System.Net;
using System.Text;

namespace Kenpotatakai.Core.Users.Messages
{
    public class RegisterUserResponse
    {
        public string UserId { get; set; }
        public HttpStatusCode? ResultCode { get; set; }
    }
}
