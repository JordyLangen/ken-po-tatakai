namespace Kenpotatakai.Core.Users.Messages
{
    public class CreateProviderBasedProfileResponse
    {
        public string UserId { get; set; }

        public string NamedId { get; set; }

        public string DisplayName { get; set; }

        public string AvatarUrl { get; set; }

        public string ProviderName { get; set; }

        public string EmailAddress { get; set; }
    }
}
