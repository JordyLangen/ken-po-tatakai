using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Kenpotatakai.Core.Users.Messages;
using MediatR;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Newtonsoft.Json;

namespace Kenpotatakai.Functions
{
    public class UserFunctionController : KenpotatakaiFunctionController
    {
        public UserFunctionController(IMediator mediator) : base(mediator)
        {
        }

        [FunctionName(nameof(GetProviderBasedProfile))]
        public async Task<HttpResponseMessage> GetProviderBasedProfile(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "users/provider/profile")]
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

            return request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}