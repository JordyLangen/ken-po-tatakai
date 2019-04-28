using System;
using System.ComponentModel.DataAnnotations;

namespace Kenpotatakai.Core
{
    public class Guard
    {
        public static void AgainstNull<T>(T value, string propertyName) where T : class
        {
            if (value == null)
            {
                throw new ArgumentException($"{propertyName} cannot be null");
            }
        }

        public static void AgainstNonEmpty(string value, string propertyName)
        {
            if (string.IsNullOrEmpty(value))
            {
                throw new ArgumentException($"{propertyName} cannot be null");
            }
        }

        public static void AgainstInvalidEmailAddress(string value)
        {
            var validator = new EmailAddressAttribute();
            if (!validator.IsValid(value))
            {
                throw new ArgumentException($"{value} is not a valid email address");
            }
        }
    }
}
