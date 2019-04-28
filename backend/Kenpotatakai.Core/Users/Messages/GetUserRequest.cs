using MediatR;

namespace Kenpotatakai.Core.Users.Messages
{
    public class GetUserRequest : IRequest<GetUserResponse>
    {
        public string SecurityId { get; set; }
        public string ProviderId { get; set; }
        public string ProviderName { get; set; }
    }
}
