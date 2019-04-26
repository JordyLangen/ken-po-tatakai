using System;
using Kenpotatakai.Core.Users;
using Kenpotatakai.Functions;
using MediatR;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Hosting;
using Microsoft.Extensions.DependencyInjection;
using RestSharp;

[assembly: WebJobsStartup(typeof(AppStartUp))]

namespace Kenpotatakai.Functions
{
    internal class AppStartUp : IWebJobsStartup
    {
        public void Configure(IWebJobsBuilder builder)
        {
#if DEBUG
            var hostName = "ken-po-tatakai.azurewebsites.net";
#else
            var hostName = Environment.GetEnvironmentVariable("WEBSITE_HOSTNAME");
#endif
            hostName = "https://" + hostName;

            builder.Services.AddMediatR(typeof(User).Assembly);
            builder.Services.AddSingleton<ServiceFactory>(provider => provider.GetService);
            builder.Services.AddScoped<IRestClient>(provider => new RestClient(hostName));
        }
    }
}
