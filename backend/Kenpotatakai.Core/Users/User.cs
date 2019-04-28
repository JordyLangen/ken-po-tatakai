namespace Kenpotatakai.Core.Users
{
    public class User
    {
        public string Id { get; }
        public string ProviderId { get; set; }
        public string ProviderName { get; }
        public string EmailAddress { get; }
        public string DisplayName { get; }
        public string AvatarUrl { get; }

        public User()
        {
            // for serialization purposes only
        }

        public User(string securityId, string providerName, string emailAddress, string displayName, string avatarUrl)
        {
            Guard.AgainstNonEmpty(securityId, nameof(Id));
            Guard.AgainstNonEmpty(providerName, nameof(ProviderName));
            Guard.AgainstNonEmpty(displayName, nameof(DisplayName));
            Guard.AgainstNonEmpty(avatarUrl, nameof(AvatarUrl));
            Guard.AgainstInvalidEmailAddress(emailAddress);

            ProviderId = $"{providerName}:{securityId}";
            ProviderName = providerName;
            EmailAddress = emailAddress;
            DisplayName = displayName;
            AvatarUrl = avatarUrl;
        }
    }
}
