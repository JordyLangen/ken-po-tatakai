using System.Linq;
using System.Security.Claims;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;

namespace Kenpotatakai.Functions.Users
{
    public class GetClaimsFunction : BaseFunction
    {
        public GetClaimsFunction(IMediator mediator) : base(mediator)
        {
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
    }
}
