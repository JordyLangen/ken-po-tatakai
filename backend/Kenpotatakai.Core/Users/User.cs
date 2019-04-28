using Newtonsoft.Json;

namespace Kenpotatakai.Core.Users
{
    public class User
    {
        public string Id { get; set; }
        [JsonProperty("platformId")]
        public string PlatformId { get; set; }
        [JsonProperty("providerId")]
        public string ProviderId { get; set; }
        [JsonProperty("providerName")]
        public string ProviderName { get; set; }
        public string EmailAddress { get; set; }
        public string DisplayName { get; set; }
        public string AvatarUrl { get; set; }

        public User()
        {
            // for serialization purposes only
        }

        public User(string securityId, string providerId, string providerName, string emailAddress, string displayName, string avatarUrl)
        {
            Guard.AgainstNonEmpty(securityId, nameof(Id));
            Guard.AgainstNonEmpty(providerId, nameof(ProviderId));
            Guard.AgainstNonEmpty(providerName, nameof(ProviderName));
            Guard.AgainstNonEmpty(displayName, nameof(DisplayName));
            Guard.AgainstNonEmpty(avatarUrl, nameof(AvatarUrl));
            Guard.AgainstInvalidEmailAddress(emailAddress);

            PlatformId = $"{providerName}:{securityId}";
            ProviderId = providerId;
            ProviderName = providerName;
            EmailAddress = emailAddress;
            DisplayName = displayName;
            AvatarUrl = avatarUrl;
        }
    }
}
