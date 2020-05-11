// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProviderBasedProfileResponse _$GetProviderBasedProfileResponseFromJson(
    Map<String, dynamic> json) {
  return GetProviderBasedProfileResponse()
    ..providerId = json['providerId'] as String
    ..namedId = json['namedId'] as String
    ..displayName = json['displayName'] as String
    ..avatarUrl = json['avatarUrl'] as String
    ..providerName = json['providerName'] as String
    ..emailAddress = json['emailAddress'] as String;
}

Map<String, dynamic> _$GetProviderBasedProfileResponseToJson(
        GetProviderBasedProfileResponse instance) =>
    <String, dynamic>{
      'providerId': instance.providerId,
      'namedId': instance.namedId,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'providerName': instance.providerName,
      'emailAddress': instance.emailAddress,
    };

GetUserResponse _$GetUserResponseFromJson(Map<String, dynamic> json) {
  return GetUserResponse()
    ..id = json['id'] as String
    ..platformId = json['platformId'] as String
    ..providerId = json['providerId'] as String
    ..providerName = json['providerName'] as String
    ..emailAddress = json['emailAddress'] as String
    ..displayName = json['displayName'] as String
    ..avatarUrl = json['avatarUrl'] as String;
}

Map<String, dynamic> _$GetUserResponseToJson(GetUserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'platformId': instance.platformId,
      'providerId': instance.providerId,
      'providerName': instance.providerName,
      'emailAddress': instance.emailAddress,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
    };

RegisterUserRequest _$RegisterUserRequestFromJson(Map<String, dynamic> json) {
  return RegisterUserRequest(
    providerId: json['providerId'] as String,
    emailAddress: json['emailAddress'] as String,
    avatarUrl: json['avatarUrl'] as String,
    displayName: json['displayName'] as String,
  );
}

Map<String, dynamic> _$RegisterUserRequestToJson(
        RegisterUserRequest instance) =>
    <String, dynamic>{
      'providerId': instance.providerId,
      'emailAddress': instance.emailAddress,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
    };

RegisterUserResponse _$RegisterUserResponseFromJson(Map<String, dynamic> json) {
  return RegisterUserResponse()
    ..userId = json['userId'] as String
    ..platformId = json['platformId'] as String
    ..providerId = json['providerId'] as String
    ..providerName = json['providerName'] as String
    ..emailAddress = json['emailAddress'] as String
    ..displayName = json['displayName'] as String
    ..avatarUrl = json['avatarUrl'] as String;
}

Map<String, dynamic> _$RegisterUserResponseToJson(
        RegisterUserResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'platformId': instance.platformId,
      'providerId': instance.providerId,
      'providerName': instance.providerName,
      'emailAddress': instance.emailAddress,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
    };
