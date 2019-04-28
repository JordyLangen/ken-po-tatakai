using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Security.Claims;
using System.Security.Principal;
using System.Threading.Tasks;
using MediatR;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;

namespace Kenpotatakai.Functions
{
    public class KenpotatakaiFunctionController
    {
        private const string ClaimTypeStableSecurityId =
            "stable_sid";

        private const string ClaimTypeProvider =
            "idp";

        private const string ClaimTypeIdentityProvider =
            "http://schemas.microsoft.com/identity/claims/identityprovider";

        private const string ClaimTypeAuthLevel =
            "http://schemas.microsoft.com/2017/07/functions/claims/authlevel";

        protected readonly IMediator Mediator;

        public KenpotatakaiFunctionController(IMediator mediator)
        {
            Mediator = mediator;
        }

        protected bool IsAuthenticated(IPrincipal claimsPrincipal)
        {
            return claimsPrincipal?.Identity != null && claimsPrincipal.Identity.IsAuthenticated;
        }

        protected async Task<T> GetRequestBody<T>(HttpRequestMessage request) where T : class, new()
        {
            try
            {
                var body = await request.Content.ReadAsStringAsync();
                return JsonConvert.DeserializeObject<T>(body);
            }
            catch (Exception)
            {
                request.CreateResponse(HttpStatusCode.BadRequest);
                return null;
            }
        }

        protected string GetStableSecurityId(HttpRequestMessage request, ClaimsPrincipal claimsPrincipal)
        {
            var claims = IsRunningLocally(claimsPrincipal)
                ? GetEasyAuthClaims(request)
                : claimsPrincipal.Claims.ToList();

            return claims.SingleOrDefault(claim => claim.Type == ClaimTypeStableSecurityId)?.Value;
        }

        protected string GetIdentityProvider(HttpRequestMessage request, ClaimsPrincipal claimsPrincipal)
        {
            var claims = IsRunningLocally(claimsPrincipal)
                ? GetEasyAuthClaims(request)
                : claimsPrincipal.Claims.ToList();

            return claims.SingleOrDefault(claim => claim.Type == ClaimTypeIdentityProvider)?.Value ??
                   claims.SingleOrDefault(claim => claim.Type == ClaimTypeProvider)?.Value;
        }

        private bool IsRunningLocally(ClaimsPrincipal claimsPrincipal)
        {
            var claims = claimsPrincipal.Claims.ToList();
            return claims.Count == 1 &&
                   claims.SingleOrDefault(claim => claim.Type == ClaimTypeAuthLevel)?
                       .Value.ToLowerInvariant() == "admin";
        }

        private static IList<Claim> GetEasyAuthClaims(HttpRequestMessage request)
        {
            var token = request.Headers.GetValues("X-ZUMO-AUTH").SingleOrDefault();
            var handler = new JwtSecurityTokenHandler();
            var decodedToken = handler.ReadToken(token) as JwtSecurityToken;
            return decodedToken?.Claims.ToList() ?? new List<Claim>();
        }

        protected MediaTypeFormatter JsonMediaTypeFormatter()
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