using System.Security.Claims;
using System.Threading.Tasks;
using Kenpotatakai.Core.Users.Messages;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;

namespace Kenpotatakai.Functions.Users
{
    public class GetUserFunction : BaseFunction
    {
        public GetUserFunction(IMediator mediator) : base(mediator)
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
    }
}
