using System;
using System.Threading;
using System.Threading.Tasks;
using Kenpotatakai.Core.Users.Messages;
using MediatR;

namespace Kenpotatakai.Core.Users.UseCases
{
    public class GetUserUseCase : IRequestHandler<GetUserRequest, GetUserResponse>
    {
        private readonly IUserRepository _repository;

        public GetUserUseCase(IUserRepository userRepository)
        {
            _repository = userRepository;
        }

        public async Task<GetUserResponse> Handle(GetUserRequest request, CancellationToken cancellationToken)
        {
            Guard.AgainstNonEmpty(request.ProviderId, nameof(request.ProviderId));
            Guard.AgainstNonEmpty(request.ProviderName, nameof(request.ProviderName));
            Guard.AgainstNonEmpty(request.SecurityId, nameof(request.SecurityId));

            var user = //await _repository.GetBy($"{request.ProviderName}:{request.SecurityId}") ??
                       await _repository.GetBy(request.ProviderId, request.ProviderName);

            return user != null ? GetUserResponse.MapFrom(user) : GetUserResponse.None();
        }
    }
}