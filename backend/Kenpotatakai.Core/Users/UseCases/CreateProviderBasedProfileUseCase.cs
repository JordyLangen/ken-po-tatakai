using System.Linq;
using System.Security.Claims;
using System.Threading;
using System.Threading.Tasks;
using Kenpotatakai.Core.Users.Messages;
using MediatR;
using Newtonsoft.Json;
using RestSharp;

namespace Kenpotatakai.Core.Users.UseCases
{
    public class CreateProviderBasedProfileUseCase : IRequestHandler<
        CreateProviderBasedProfileRequest,
        CreateProviderBasedProfileResponse>
    {
        private readonly IRestClient _restClient;

        public CreateProviderBasedProfileUseCase(IRestClient restClient)
        {
            _restClient = restClient;
        }

        public async Task<CreateProviderBasedProfileResponse> Handle(CreateProviderBasedProfileRequest request,
            CancellationToken cancellationToken)
        {
            if (string.IsNullOrEmpty(request.AuthenticationToken))
            {
                return new CreateProviderBasedProfileResponse();
            }

            var authMeRequest = new RestRequest("/.auth/me", Method.GET);
            authMeRequest.AddHeader("X-ZUMO-AUTH", request.AuthenticationToken);

            var response = await _restClient.ExecuteTaskAsync(authMeRequest, cancellationToken);
            var authMeResponse = JsonConvert.DeserializeObject<AuthMeResponse[]>(response.Content)
                .SingleOrDefault();

            if (authMeResponse == null)
            {
                return new CreateProviderBasedProfileResponse();
            }

            if (authMeResponse.ProviderName == "twitter")
            {
                return HandleTwitterAuthMeResponse(authMeResponse);
            }

            return HandleAuthMeResponse(authMeResponse);
        }

        private CreateProviderBasedProfileResponse HandleTwitterAuthMeResponse(AuthMeResponse authMeResponse)
        {
            var avatarUrl = GetClaim(authMeResponse, "urn:twitter:profile_image_url_https");
            if (!string.IsNullOrEmpty(avatarUrl))
            {
                avatarUrl = avatarUrl.Replace("bw_normal.jpg", "bw_400x400.jpg");
            }

            return new CreateProviderBasedProfileResponse
            {
                DisplayName = GetClaim(authMeResponse, ClaimTypes.Name),
                NamedId = authMeResponse.UserId,
                UserId = GetClaim(authMeResponse, ClaimTypes.NameIdentifier),
                ProviderName = authMeResponse.ProviderName,
                AvatarUrl = avatarUrl
            };
        }

        private CreateProviderBasedProfileResponse HandleAuthMeResponse(AuthMeResponse authMeResponse)
        {
            return new CreateProviderBasedProfileResponse
            {
                UserId = authMeResponse.UserId,
                ProviderName = authMeResponse.ProviderName
            };
        }

        private string GetClaim(AuthMeResponse authMeResponse, string claimType)
        {
            return authMeResponse.UserClaims?.SingleOrDefault(claim => claim.Type == claimType)?.Value;
        }
    }

    internal class AuthMeResponse
    {
        [JsonProperty("access_token", NullValueHandling = NullValueHandling.Ignore)]
        public string AccessToken { get; set; }

        [JsonProperty("provider_name", NullValueHandling = NullValueHandling.Ignore)]
        public string ProviderName { get; set; }

        [JsonProperty("user_id", NullValueHandling = NullValueHandling.Ignore)]
        public string UserId { get; set; }

        [JsonProperty("user_claims", NullValueHandling = NullValueHandling.Ignore)]
        public AuthUserClaim[] UserClaims { get; set; }

        [JsonProperty("access_token_secret", NullValueHandling = NullValueHandling.Ignore)]
        public string AccessTokenSecret { get; set; }

        [JsonProperty("authentication_token", NullValueHandling = NullValueHandling.Ignore)]
        public string AuthenticationToken { get; set; }

        [JsonProperty("expires_on", NullValueHandling = NullValueHandling.Ignore)]
        public string ExpiresOn { get; set; }

        [JsonProperty("id_token", NullValueHandling = NullValueHandling.Ignore)]
        public string IdToken { get; set; }

        [JsonProperty("refresh_token", NullValueHandling = NullValueHandling.Ignore)]
        public string RefreshToken { get; set; }
    }

    internal class AuthUserClaim
    {
        [JsonProperty("typ")]
        public string Type { get; set; }

        [JsonProperty("val")]
        public string Value { get; set; }
    }
}