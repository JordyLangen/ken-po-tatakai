using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Claims;
using System.Threading.Tasks;
using Kenpotatakai.Core.Users.Messages;
using MediatR;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;

namespace Kenpotatakai.Functions
{
    public class UserFunctionController : KenpotatakaiFunctionController
    {
        public UserFunctionController(IMediator mediator) : base(mediator)
        {
        }

        [FunctionName(nameof(GetProviderBasedProfile))]
        public async Task<HttpResponseMessage> GetProviderBasedProfile(
            [HttpTrigger(AuthorizationLevel.Anonymous, "GET", Route = "users/provider/profile")]
            HttpRequestMessage request,
            ClaimsPrincipal principal)
        {
            if (!IsAuthenticated(principal))
            {
                return request.CreateResponse(HttpStatusCode.Unauthorized);
            }

            var createProviderBasedProfileRequest = new CreateProviderBasedProfileRequest
            {
                AuthenticationToken = request.Headers.Authorization.Parameter
            };

            var response = await Mediator.Send(createProviderBasedProfileRequest);

            return request.CreateResponse(HttpStatusCode.OK, response, JsonMediaTypeFormatter());
        }

        [FunctionName(nameof(GetClaims))]
        public HttpResponseMessage GetClaims(
            [HttpTrigger(AuthorizationLevel.Anonymous, "GET", Route = "users/claims")] HttpRequestMessage request,
            ClaimsPrincipal principal)
        {
            if (!IsAuthenticated(principal))
            {
                return request.CreateResponse(HttpStatusCode.Unauthorized);
            }

            var claims = principal.Claims
                .Select(claim => new
                {
                    claim.Type,
                    claim.Value
                })
                .ToList();

            return request.CreateResponse(HttpStatusCode.OK, claims, JsonMediaTypeFormatter());
        }

        [FunctionName(nameof(RegisterUser))]
        public async Task<HttpResponseMessage> RegisterUser(
            [HttpTrigger(AuthorizationLevel.Anonymous, "POST", Route = "users")]
            HttpRequestMessage request,
            ClaimsPrincipal principal)
        {
            if (!IsAuthenticated(principal))
            {
                return request.CreateResponse(HttpStatusCode.Unauthorized);
            }

            var registerUserRequest = await GetRequestBody<RegisterUserRequest>(request);

            registerUserRequest.SecurityId = GetStableSecurityId(request, principal);
            registerUserRequest.ProviderName = GetIdentityProvider(request, principal);

            var response = await Mediator.Send(registerUserRequest);

            return request.CreateResponse(HttpStatusCode.OK, response, JsonMediaTypeFormatter());
        }
    }
}