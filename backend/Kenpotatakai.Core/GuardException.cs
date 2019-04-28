using System;
using System.Collections.Generic;
using System.Text;

namespace Kenpotatakai.Core
{
    public class GuardException : Exception
    {
        public GuardException(string message) : base(message)
        {
        }
    }
}