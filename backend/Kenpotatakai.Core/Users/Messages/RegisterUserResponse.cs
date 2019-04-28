using System;
using System.Collections.Generic;
using System.Text;

namespace Kenpotatakai.Core.Users.Messages
{
    public class RegisterUserResponse
    {
        public string UserId { get; set; }
        public bool IsCreated { get; set; }
    }
}
