using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Security.Claims;
using System.Threading.Tasks;
using Kenpotatakai.Core;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;

namespace Kenpotatakai
{
    public static class HttpRequestMessageExtensions
    {
        public static string GetEasyAuthToken(this HttpRequestMessage request)
        {
            return request.Headers.GetValues("X-ZUMO-AUTH").SingleOrDefault();
        }

        public static IList<Claim> GetEasyAuthClaims(this HttpRequestMessage request)
        {
            var token = GetEasyAuthToken(request);
            var handler = new JwtSecurityTokenHandler();
            var decodedToken = handler.ReadToken(token) as JwtSecurityToken;
            return decodedToken?.Claims.ToList() ?? new List<Claim>();
        }

        public static async Task<T> GetRequestBody<T>(this HttpRequestMessage request) where T : class, new()
        {
            var body = await request.Content.ReadAsStringAsync();
            return JsonConvert.DeserializeObject<T>(body);
        }

        public static HttpResponseMessage ResponseTo(this HttpRequestMessage request, GuardException exception)
        {
            var body = new GuardExceptionResponse
            {
                ErrorMessage = exception.Message
            };

            return RespondBadRequest(request, body);
        }

        public static HttpResponseMessage RespondOk<T>(this HttpRequestMessage request, T body)
        {
            return request.CreateResponse(HttpStatusCode.OK, body, JsonMediaTypeFormatter());
        }

        public static HttpResponseMessage RespondBadRequest<T>(this HttpRequestMessage request, T body)
        {
            return request.CreateResponse(HttpStatusCode.BadRequest, body, JsonMediaTypeFormatter());
        }

        public static MediaTypeFormatter JsonMediaTypeFormatter()
        {
            return new JsonMediaTypeFormatter
            {
                Indent = true,
                SerializerSettings = new JsonSerializerSettings
                {
                    ContractResolver = new CamelCasePropertyNamesContractResolver()
                }
            };
        }
    }
}
