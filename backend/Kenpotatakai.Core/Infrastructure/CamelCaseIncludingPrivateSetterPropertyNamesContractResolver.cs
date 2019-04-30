using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;

namespace Kenpotatakai.Core.Infrastructure
{
    public class CamelCaseIncludingPrivateSetterPropertyNamesContractResolver : CamelCasePropertyNamesContractResolver
    {
        protected override JsonProperty CreateProperty(MemberInfo member, MemberSerialization memberSerialization)
        {
            var property = base.CreateProperty(member, memberSerialization);

            if (property.Writable)
            {
                return property;
            }

            var propertyInfo = member as PropertyInfo;
            property.Writable = propertyInfo?.SetMethod != null;

            return property;
        }
    }
}
