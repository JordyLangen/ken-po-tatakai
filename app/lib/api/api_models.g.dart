// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProviderBasedProfileResponse _$GetProviderBasedProfileResponseFromJson(
    Map<String, dynamic> json) {
  return GetProviderBasedProfileResponse(
      providerId: json['providerId'] as String,
      namedId: json['namedId'] as String,
      providerName: json['providerName'] as String,
      avatarUrl: json['avatarUrl'] as String,
      displayName: json['displayName'] as String,
      emailAddress: json['emailAddress'] as String);
}

Map<String, dynamic> _$GetProviderBasedProfileResponseToJson(
        GetProviderBasedProfileResponse instance) =>
    <String, dynamic>{
      'providerId': instance.providerId,
      'namedId': instance.namedId,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'providerName': instance.providerName,
      'emailAddress': instance.emailAddress
    };

GetUserResponse _$GetUserResponseFromJson(Map<String, dynamic> json) {
  return GetUserResponse(
      emailAddress: json['emailAddress'] as String,
      displayName: json['displayName'] as String,
      avatarUrl: json['avatarUrl'] as String,
      providerName: json['providerName'] as String,
      providerId: json['providerId'] as String,
      platformId: json['platformId'] as String);
}

Map<String, dynamic> _$GetUserResponseToJson(GetUserResponse instance) =>
    <String, dynamic>{
      'platformId': instance.platformId,
      'providerId': instance.providerId,
      'providerName': instance.providerName,
      'emailAddress': instance.emailAddress,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl
    };
