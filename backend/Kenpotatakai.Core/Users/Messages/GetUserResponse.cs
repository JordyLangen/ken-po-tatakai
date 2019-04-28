namespace Kenpotatakai.Core.Users.Messages
{
    public class GetUserResponse
    {
        public string PlatformId { get; set; }
        public string ProviderId { get; set; }
        public string ProviderName { get; set; }
        public string EmailAddress { get; set; }
        public string DisplayName { get; set; }
        public string AvatarUrl { get; set; }

        private GetUserResponse()
        {
            
        }

        public static GetUserResponse None()
        {
            return new GetUserResponse();
        }

        public static GetUserResponse MapFrom(User user)
        {
            return new GetUserResponse
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
