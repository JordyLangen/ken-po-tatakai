using System.Net;
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
using ConflictResult = Microsoft.AspNetCore.Mvc.ConflictResult;

namespace Kenpotatakai.Functions.Users
{
    public class RegisterUserFunction : BaseFunction
    {
        public RegisterUserFunction(IMediator mediator) : base(mediator)
        {
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
                    return new OkObjectResult(response);
                }

                if (response.ResultCode == HttpStatusCode.Conflict)
                {
                    return new ConflictResult();
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
