namespace Kenpotatakai.Core.Users
{
    public class User
    {
        public string Id { get; }
        public string PlatformId { get; set; }
        public string ProviderId { get; set; }
        public string ProviderName { get; }
        public string EmailAddress { get; }
        public string DisplayName { get; }
        public string AvatarUrl { get; }

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
