using System.Security.Principal;
using MediatR;

namespace Kenpotatakai.Functions
{
    public class KenpotatakaiFunctionController
    {
        protected readonly IMediator Mediator;

        public KenpotatakaiFunctionController(IMediator mediator)
        {
            Mediator = mediator;
        }

        protected bool IsAuthenticated(IPrincipal claimsPrincipal)
        {
            return claimsPrincipal?.Identity != null && claimsPrincipal.Identity.IsAuthenticated;
        }
    }
}