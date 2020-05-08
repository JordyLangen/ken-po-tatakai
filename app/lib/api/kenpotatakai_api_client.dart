import 'dart:convert';

import 'package:kenpotatakai/api/api_models.dart';
import 'package:dio/dio.dart';

class KenpotatakaiApiClient {
  static const String ApiUrl = 'https://ken-po-tatakai.azurewebsites.net';

  static const String AuthEndpoint = '/.auth';
  static const String AuthSignUpEndpoint = ApiUrl + AuthEndpoint + '/login';
  static const String AuthSignUpDoneEndpoint = AuthSignUpEndpoint + '/done';

  static const String UsersEndpoint = '/api/users';
  static const String UserProviderBasedProfileEndpoint = UsersEndpoint + '/provider/profile';
  static const String GetUserEndpoint = UsersEndpoint;
  static const String RegisterUserEndpoint = UsersEndpoint;

  Dio _dio;

  KenpotatakaiApiClient(String authenticationToken) {
    _dio = Dio(BaseOptions(baseUrl: ApiUrl, headers: {'X-ZUMO-AUTH': authenticationToken}));
  }

  Future<GetProviderBasedProfileResponse> getProviderBasedProfile() async {
    var response = await _dio.get(UserProviderBasedProfileEndpoint);
    var responseBody = jsonDecode(response.toString());
    return GetProviderBasedProfileResponse.fromJson(responseBody);
  }

  Future<GetUserResponse> getUser(String providerId) async {
    try {
      var response = await _dio.get(GetUserEndpoint, queryParameters: {'providerId': providerId});
      var responseBody = jsonDecode(response.toString());
      return GetUserResponse.fromJson(responseBody);
    } on DioError catch (exception) {
      print(exception);
      return null;
    }
  }

  Future<RegisterUserResponse> registerUser(RegisterUserRequest request) async {
    try {
      var response = await _dio.post(RegisterUserEndpoint, data: request.toJson());
      var responseBody = jsonDecode(response.toString());
      return RegisterUserResponse.fromJson(responseBody);
    } on DioError catch (exception) {
      print(exception);
      return null;
    }
  }
}
