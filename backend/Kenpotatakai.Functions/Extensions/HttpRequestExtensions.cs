using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.IO;
using System.Linq;
using System.Security.Claims;
using Kenpotatakai.Core.Infrastructure;
using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;

namespace Kenpotatakai.Functions.Extensions
{
    public static class HttpRequestExtensions
    {
        private static readonly JsonSerializerSettings JsonSerializerSettings = new JsonSerializerSettings
        {
            ContractResolver = new CamelCaseIncludingPrivateSetterPropertyNamesContractResolver()
        };

        public static string GetEasyAuthToken(this HttpRequest request)
        {
            return request.Headers["X-ZUMO-AUTH"].SingleOrDefault();
        }

        public static IList<Claim> GetEasyAuthClaims(this HttpRequest request)
        {
            var token = GetEasyAuthToken(request);
            var handler = new JwtSecurityTokenHandler();
            var decodedToken = handler.ReadToken(token) as JwtSecurityToken;
            return decodedToken?.Claims.ToList() ?? new List<Claim>();
        }

        public static T GetRequestBody<T>(this HttpRequest request)
        {
            var requestBody = new StreamReader(request.Body).ReadToEnd();
            return JsonConvert.DeserializeObject<T>(requestBody, JsonSerializerSettings);
        }
    }
}
