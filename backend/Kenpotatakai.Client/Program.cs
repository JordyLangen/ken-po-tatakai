﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
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
            {nameof(GetProviderBasedProfile), GetProviderBasedProfile }
        };

        static void Main(string[] args)
        {
            _token = File.ReadAllText("authenticationtoken.txt");
            _restClient = new RestClient(LocalFunctionsApiUrl);
            _restClient.AddDefaultHeader("X-ZUMO-AUTH", _token);
            _restClient.AddDefaultHeader("Authorization", "Bearer " + _token);

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
    }
}