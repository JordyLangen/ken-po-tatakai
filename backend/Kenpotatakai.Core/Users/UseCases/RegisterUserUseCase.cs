using System;
using System.Net;
using System.Threading;
using System.Threading.Tasks;
using Kenpotatakai.Core.Users.Messages;
using MediatR;
using Microsoft.Azure.Documents;

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
                request.ProviderId,
                request.ProviderName,
                request.EmailAddress,
                request.DisplayName,
                request.AvatarUrl);

            try
            {
                var result = await _repository.Create(user);

                return new RegisterUserResponse
                {
                    UserId = result.Resource.Id,
                    ResultCode = result.StatusCode
                };
            }
            catch (DocumentClientException exception)
            {
                return new RegisterUserResponse
                {
                    ResultCode = exception.StatusCode
                };
            }
        }
    }
}