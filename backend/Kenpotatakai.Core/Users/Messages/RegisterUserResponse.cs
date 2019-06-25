using System.Net;

namespace Kenpotatakai.Core.Users.Messages
{
    public class RegisterUserResponse
    {
        public string UserId { get; set; }
        public HttpStatusCode? ResultCode { get; set; }
        public string PlatformId { get; set; }
        public string ProviderId { get; set; }
        public string ProviderName { get; set; }
        public string EmailAddress { get; set; }
        public string DisplayName { get; set; }
        public string AvatarUrl { get; set; }

        public static RegisterUserResponse MapFrom(User user)
        {
            return new RegisterUserResponse
            {
                ProviderId = user.ProviderId,
                EmailAddress = user.EmailAddress,
                AvatarUrl = user.AvatarUrl,
                ProviderName = user.ProviderName,
                DisplayName = user.DisplayName,
                PlatformId = user.PlatformId
            };
        }
    }
}
