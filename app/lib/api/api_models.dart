import 'package:json_annotation/json_annotation.dart';

part 'api_models.g.dart';

@JsonSerializable()
class GetProviderBasedProfileResponse {
  String providerId;
  String namedId;
  String displayName;
  String avatarUrl;
  String providerName;
  String emailAddress;

  GetProviderBasedProfileResponse();

  factory GetProviderBasedProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$GetProviderBasedProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetProviderBasedProfileResponseToJson(this);
}

@JsonSerializable()
class GetUserResponse {
  String platformId;
  String providerId;
  String providerName;
  String emailAddress;
  String displayName;
  String avatarUrl;

  GetUserResponse();

  factory GetUserResponse.fromJson(Map<String, dynamic> json) => _$GetUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserResponseToJson(this);
}

@JsonSerializable()
class RegisterUserRequest {
  String providerId;
  String emailAddress;
  String displayName;
  String avatarUrl;

  RegisterUserRequest({this.providerId, this.emailAddress, this.avatarUrl, this.displayName});

  factory RegisterUserRequest.fromJson(Map<String, dynamic> json) => _$RegisterUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterUserRequestToJson(this);
}

@JsonSerializable()
class RegisterUserResponse {
  String userId;
  String platformId;
  String providerId;
  String providerName;
  String emailAddress;
  String displayName;
  String avatarUrl;

  RegisterUserResponse();

  factory RegisterUserResponse.fromJson(Map<String, dynamic> json) => _$RegisterUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterUserResponseToJson(this);
}
