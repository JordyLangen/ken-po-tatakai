using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;

namespace Kenpotatakai.Core.Infrastructure
{
    public class PrivateSetterAndConstructorCamelCasePropertyNamesContractResolver : CamelCasePropertyNamesContractResolver
    {
        protected override JsonObjectContract CreateObjectContract(Type objectType)
        {
            var contract = base.CreateObjectContract(objectType);

            if (contract.DefaultCreator != null || contract.OverrideCreator != null || contract.CreatorParameters.Any())
            {
                return contract;
            }

            var constructorInfo = objectType
                .GetConstructors(BindingFlags.Instance | BindingFlags.NonPublic)
                .OrderByDescending(info => info.GetParameters().Length)
                .FirstOrDefault();

            if (constructorInfo == null)
            {
                return contract;
            }


            contract.OverrideCreator = args => constructorInfo.Invoke(args);

            foreach (var parameter in CreateConstructorParameters(constructorInfo, contract.Properties))
            {
                contract.CreatorParameters.Add(parameter);
            }

            return contract;
        }

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
