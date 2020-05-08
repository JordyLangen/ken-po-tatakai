// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..userId = json['userId'] as String
    ..providerId = json['providerId'] as String
    ..platformId = json['namedId'] as String
    ..displayName = json['displayName'] as String
    ..avatarUrl = json['avatarUrl'] as String
    ..providerName = json['providerName'] as String
    ..emailAddress = json['emailAddress'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'providerId': instance.providerId,
      'namedId': instance.platformId,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'providerName': instance.providerName,
      'emailAddress': instance.emailAddress
    };
