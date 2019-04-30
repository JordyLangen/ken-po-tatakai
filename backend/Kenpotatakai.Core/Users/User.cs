using Newtonsoft.Json;

namespace Kenpotatakai.Core.Users
{
    public class User
    {
        public string Id { get; private set; }

        [JsonProperty("platformId")]
        public string PlatformId { get; private set; }

        [JsonProperty("providerId")]
        public string ProviderId { get; private set; }

        [JsonProperty("providerName")]
        public string ProviderName { get; private set; }

        public string EmailAddress { get; private set; }
        public string DisplayName { get; private set; }
        public string AvatarUrl { get; private set; }

        [JsonConstructor]
        public User(
            string id,
            string platformId,
            string providerId,
            string providerName,
            string emailAddress,
            string displayName,
            string avatarUrl)
        {
            Guard.AgainstNonEmpty(id, nameof(Id));
            Guard.AgainstNonEmpty(platformId, nameof(PlatformId));
            Guard.AgainstNonEmpty(providerId, nameof(ProviderId));
            Guard.AgainstNonEmpty(providerName, nameof(ProviderName));
            Guard.AgainstNonEmpty(displayName, nameof(DisplayName));
            Guard.AgainstNonEmpty(avatarUrl, nameof(AvatarUrl));
            Guard.AgainstInvalidEmailAddress(emailAddress);

            Id = id;
            PlatformId = platformId;
            ProviderId = providerId;
            ProviderName = providerName;
            EmailAddress = emailAddress;
            DisplayName = displayName;
            AvatarUrl = avatarUrl;
        }

        public User(
            string securityId,
            string providerId,
            string providerName,
            string emailAddress,
            string displayName,
            string avatarUrl)
        {
            Guard.AgainstNonEmpty(securityId, nameof(securityId));
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