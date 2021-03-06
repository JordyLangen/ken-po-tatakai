﻿using System.Linq;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Security.Claims;
using System.Security.Principal;
using Kenpotatakai.Functions.Extensions;
using MediatR;
using Microsoft.AspNetCore.Http;

namespace Kenpotatakai.Functions
{
    public class BaseFunction
    {
        private const string ClaimTypeStableSecurityId =
            "stable_sid";

        private const string ClaimTypeProvider =
            "idp";

        private const string ClaimTypeIdentityProvider =
            "http://schemas.microsoft.com/identity/claims/identityprovider";

        private const string ClaimTypeAuthLevel =
            "http://schemas.microsoft.com/2017/07/functions/claims/authlevel";

        protected readonly IMediator Mediator;

        public BaseFunction(IMediator mediator)
        {
            Mediator = mediator;
        }

        protected bool IsAuthenticated(IPrincipal claimsPrincipal)
        {
            return claimsPrincipal?.Identity != null && claimsPrincipal.Identity.IsAuthenticated;
        }

        protected string GetSecurityId(HttpRequest request, ClaimsPrincipal claimsPrincipal)
        {
            var claims = IsRunningLocally(claimsPrincipal)
                ? request.GetEasyAuthClaims()
                : claimsPrincipal.Claims.ToList();

            return claims.SingleOrDefault(claim => claim.Type == ClaimTypeStableSecurityId)?.Value;
        }

        protected string GetIdentityProvider(HttpRequest request, ClaimsPrincipal claimsPrincipal)
        {
            var claims = IsRunningLocally(claimsPrincipal)
                ? request.GetEasyAuthClaims()
                : claimsPrincipal.Claims.ToList();

            return claims.SingleOrDefault(claim => claim.Type == ClaimTypeIdentityProvider)?.Value ??
                   claims.SingleOrDefault(claim => claim.Type == ClaimTypeProvider)?.Value;
        }

        private bool IsRunningLocally(ClaimsPrincipal claimsPrincipal)
        {
            var claims = claimsPrincipal.Claims.ToList();
            return claims.Count == 1 &&
                   claims.SingleOrDefault(claim => claim.Type == ClaimTypeAuthLevel)?
                       .Value.ToLowerInvariant() == "admin";
        }
    }
}