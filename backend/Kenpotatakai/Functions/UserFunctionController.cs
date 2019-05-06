using System.IO;
using System.Linq;
using System.Net;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web.Http;
using Kenpotatakai.Core;
using Kenpotatakai.Core.Users.Messages;
using Kenpotatakai.Extensions;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Newtonsoft.Json;

namespace Kenpotatakai.Functions
{
    public class UserFunctionController : BaseFunctionController
    {
        public UserFunctionController(IMediator mediator) : base(mediator)
        {
        }

        [FunctionName(nameof(GetUser))]
        public async Task<IActionResult> GetUser(
            [HttpTrigger(AuthorizationLevel.Anonymous, "GET", Route = "users")] HttpRequest request,
            ClaimsPrincipal principal)
        {
            if (!IsAuthenticated(principal))
            {
                return new UnauthorizedResult();
            }

            var getUserRequest = new GetUserRequest
            {
                ProviderName = GetIdentityProvider(request, principal),
                SecurityId = GetSecurityId(request, principal),
                ProviderId = request.Query["providerId"]
            };

            var response = await Mediator.Send(getUserRequest);

            if (string.IsNullOrEmpty(response?.PlatformId))
            {
                return new NotFoundResult();
            }

            return new OkObjectResult(response);
        }

        [FunctionName(nameof(GetProviderBasedProfile))]
        public async Task<IActionResult> GetProviderBasedProfile(
            [HttpTrigger(AuthorizationLevel.Anonymous, "GET", Route = "users/provider/profile")]
            HttpRequest request,
            ClaimsPrincipal principal)
        {
            if (!IsAuthenticated(principal))
            {
                return new UnauthorizedResult();
            }

            var createProviderBasedProfileRequest = new CreateProviderBasedProfileRequest
            {
                AuthenticationToken = request.GetEasyAuthToken()
            };

            try
            {
                var response = await Mediator.Send(createProviderBasedProfileRequest);
                return new OkObjectResult(response);
            }
            catch (GuardException exception)
            {
                return new BadRequestErrorMessageResult(exception.Message);
            }
        }

        [FunctionName(nameof(GetClaims))]
        public IActionResult GetClaims(
            [HttpTrigger(AuthorizationLevel.Anonymous, "GET", Route = "users/claims")] HttpRequest request,
            ClaimsPrincipal principal)
        {
            if (!IsAuthenticated(principal))
            {
                return new UnauthorizedResult();
            }

            var claims = principal.Claims
                .Select(claim => new
                {
                    claim.Type,
                    claim.Value
                })
                .ToList();

            return new OkObjectResult(claims);
        }

        [FunctionName(nameof(RegisterUser))]
        public async Task<IActionResult> RegisterUser(
            [HttpTrigger(AuthorizationLevel.Anonymous, "POST", Route = "users")] HttpRequest request,
            ClaimsPrincipal principal)
        {
            if (!IsAuthenticated(principal))
            {
                return new UnauthorizedResult();
            }
            
            var registerUserRequest = request.GetRequestBody<RegisterUserRequest>();

            registerUserRequest.SecurityId = GetSecurityId(request, principal);
            registerUserRequest.ProviderName = GetIdentityProvider(request, principal);

            try
            {
                var response = await Mediator.Send(registerUserRequest);

                if (response.ResultCode == HttpStatusCode.OK || response.ResultCode == HttpStatusCode.Created)
                {
                    return new CreatedAtRouteResult("users", response.UserId, response);
                }

                if (response.ResultCode == HttpStatusCode.Conflict)
                {
                    return new System.Web.Http.ConflictResult();
                }

                return new InternalServerErrorResult();
            }
            catch (GuardException exception)
            {
                return new BadRequestErrorMessageResult(exception.Message);
            }
        }
    }
}