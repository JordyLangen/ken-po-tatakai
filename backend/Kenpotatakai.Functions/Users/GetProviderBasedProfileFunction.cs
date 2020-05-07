using System.Security.Claims;
using System.Threading.Tasks;
using System.Web.Http;
using Kenpotatakai.Core;
using Kenpotatakai.Core.Users.Messages;
using Kenpotatakai.Functions.Extensions;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;

namespace Kenpotatakai.Functions.Users
{
    public class GetProviderBasedProfileFunction : BaseFunction
    {
        public GetProviderBasedProfileFunction(IMediator mediator) : base(mediator)
        {
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
    }
}
