using System.Net;
using System.Threading;
using System.Threading.Tasks;
using Kenpotatakai.Core.Users.Messages;
using MediatR;

namespace Kenpotatakai.Core.Users.UseCases
{
    public class RegisterUserUseCase : IRequestHandler<
        RegisterUserRequest,
        RegisterUserResponse>
    {
        private readonly IUserRepository _repository;

        public RegisterUserUseCase(IUserRepository userRepository)
        {
            _repository = userRepository;
        }

        public async Task<RegisterUserResponse> Handle(RegisterUserRequest request, CancellationToken cancellationToken)
        {
            var user = new User(
                request.SecurityId,
                request.ProviderName,
                request.EmailAddress,
                request.DisplayName,
                request.AvatarUrl);

            var result = await _repository.Create(user);

            return new RegisterUserResponse
            {
                UserId = result.Resource.Id,
                IsCreated = result.StatusCode == HttpStatusCode.OK || result.StatusCode == HttpStatusCode.Created
            };
        }
    }
}