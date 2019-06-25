using System;
using System.Net;
using System.Threading;
using System.Threading.Tasks;
using Kenpotatakai.Core.Users.Messages;
using MediatR;
using Microsoft.Azure.Documents;

namespace Kenpotatakai.Core.Users.UseCases
{
    public class RegisterUserUseCase : IRequestHandler<RegisterUserRequest, RegisterUserResponse>
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

                var response = RegisterUserResponse.MapFrom(user);
                response.UserId = result.Resource.Id;
                response.ResultCode = result.StatusCode;
                return response;
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