using MediatR;

namespace Kenpotatakai.Core.Users.Messages
{
    public class RegisterUserRequest : IRequest<RegisterUserResponse>
    {
        public string SecurityId { get; set; }
        public string ProviderId { get; set; }
        public string ProviderName { get; set; }
        public string EmailAddress { get; set; }
        public string DisplayName { get; set; }
        public string AvatarUrl { get; set; }
    }
}
