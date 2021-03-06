﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using Kenpotatakai.Core.Users.Messages;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using RestSharp;

namespace Kenpotatakai.Client
{
    class Program
    {
        private const string HostedFunctionsApiUrl = "https://ken-po-tatakai.azurewebsites.net";
        private const string LocalFunctionsApiUrl = "http://localhost:7071";

        private static string _token;
        private static IRestClient _restClient;

        private static readonly Dictionary<string, Action> Requests = new Dictionary<string, Action>
        {
            {nameof(GetProviderBasedProfile), GetProviderBasedProfile},
            {nameof(GetClaims), GetClaims},
            {nameof(RegisterUser), RegisterUser},
            {nameof(GetUser), GetUser}
        };

        static void Main(string[] args)
        {
            _token = File.ReadAllText("authenticationtoken.txt");
            _restClient = new RestClient(HostedFunctionsApiUrl);
            _restClient.AddDefaultHeader("X-ZUMO-AUTH", _token);

            ShowRequestOptions();
        }

        static void ShowRequestOptions()
        {
            Console.WriteLine("Choose a request:");

            var requestKeys = Requests.Keys.ToList();
            for (var index = 0; index < Requests.Count; index++)
            {
                Console.WriteLine($"[{index}] {requestKeys[index]}");
            }

            var choice = Console.ReadLine();
            Console.Clear();

            if (int.TryParse(choice, out var chosenRequestIndex))
            {
                var key = requestKeys[chosenRequestIndex];
                Requests[key]();
            }

            ShowRequestOptions();
        }

        static void GetProviderBasedProfile()
        {
            Console.WriteLine("Executing GetProviderBasedProfile...");

            var request = new RestRequest("/api/users/provider/profile", Method.GET);
            var response = _restClient.Execute(request);

            Console.WriteLine("GetProviderBasedProfile result:");
            Console.WriteLine(response.StatusCode);
            Console.WriteLine(JObject.Parse(response.Content).ToString(Formatting.Indented));
            Console.WriteLine();
        }

        static void GetClaims()
        {
            Console.WriteLine("Executing GetClaims...");

            var request = new RestRequest("/api/users/claims", Method.GET);
            var response = _restClient.Execute(request);

            Console.WriteLine("GetClaims result:");
            Console.WriteLine(response.StatusCode);
            Console.WriteLine(JArray.Parse(response.Content).ToString(Formatting.Indented));
            Console.WriteLine();
        }

        static void RegisterUser()
        {
            Console.WriteLine("Executing RegisterUser...");

            var request = new RestRequest("/api/users", Method.POST);
            var requestBody = JsonConvert.DeserializeObject<RegisterUserRequest>(File.ReadAllText("Requests/RegisterUser.json"));
            request.AddJsonBody(requestBody);

            var response = _restClient.Execute(request);

            Console.WriteLine("RegisterUser result:");
            Console.WriteLine(response.StatusCode);
            Console.WriteLine(JObject.Parse(response.Content).ToString(Formatting.Indented));
            Console.WriteLine();
        }

        static void GetUser()
        {
            Console.WriteLine("Executing GetUser...");

            var request = new RestRequest("/api/users", Method.GET);
            var requestParameters = JObject.Parse(File.ReadAllText("Requests/GetUser.json"));
            request.AddQueryParameter("providerId", requestParameters["providerId"].Value<string>());
            var response = _restClient.Execute(request);

            Console.WriteLine("GetUser result:");
            Console.WriteLine(response.StatusCode);
            if (response.StatusCode == HttpStatusCode.OK)
            {
                Console.WriteLine(JObject.Parse(response.Content).ToString(Formatting.Indented));
            }
            Console.WriteLine();
        }
    }
}