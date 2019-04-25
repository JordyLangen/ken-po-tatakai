using MediatR;

namespace Kenpotatakai.Core.Users.Messages
{
    public class CreateProviderBasedProfileRequest : IRequest<CreateProviderBasedProfileResponse>
    {
        public string AuthenticationToken { get; set; }
    }
}
