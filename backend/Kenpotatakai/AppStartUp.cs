using System;
using System.Linq;
using Kenpotatakai;
using Kenpotatakai.Core.Infrastructure;
using MediatR;
using Microsoft.Azure.Documents;
using Microsoft.Azure.Documents.Client;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using RestSharp;
using User = Kenpotatakai.Core.Users.User;


[assembly: WebJobsStartup(typeof(AppStartUp))]

namespace Kenpotatakai
{
    internal class AppStartUp : IWebJobsStartup
    {
        public void Configure(IWebJobsBuilder builder)
        {
            RegisterDependencies(builder.Services);
        }

        private string GetHostName()
        {
#if DEBUG
            var hostName = "ken-po-tatakai.azurewebsites.net";
#else
            var hostName = Environment.GetEnvironmentVariable("WEBSITE_HOSTNAME");
#endif
            hostName = "https://" + hostName;

            return hostName;
        }

        private static IConfigurationRoot BuildConfig()
        {
            return new ConfigurationBuilder()
#if DEBUG
                .SetBasePath(Environment.GetEnvironmentVariable("AzureWebJobsScriptRoot"))
#endif
                .AddJsonFile("local.settings.json", optional: true, reloadOnChange: true)
                .AddEnvironmentVariables()
                .Build();
        }

        private void RegisterDependencies(IServiceCollection services)
        {
            var config = BuildConfig();

            services.AddMediatR(typeof(User).Assembly);

            services.AddSingleton<ServiceFactory>(provider => provider.GetService);

            services.AddScoped<IRestClient>(provider =>
                new RestClient(GetHostName()));

            services.AddScoped<IDocumentClient>(provider => new DocumentClient(
                new Uri(config["Cosmos:EndpointUrl"]),
                config["Cosmos:Key"], new JsonSerializerSettings
                {
                    ContractResolver = new CamelCaseIncludingPrivateSetterPropertyNamesContractResolver()
                }));

            RegisterTransientImplementedInterfaces(services, "Repository");
        }

        private void RegisterTransientImplementedInterfaces(IServiceCollection services, string classNameSuffix)
        {
            var types = typeof(User).Assembly.GetTypes()
                .Where(type => type.Name.EndsWith(classNameSuffix) && type.IsClass && !type.IsAbstract)
                .ToList();

            foreach (var implementationType in types)
            {
                var serviceType = implementationType.GetInterfaces()
                    .SingleOrDefault(type => type.Name.EndsWith(implementationType.Name));

                services.AddTransient(serviceType, implementationType);
            }
        }
    }
}