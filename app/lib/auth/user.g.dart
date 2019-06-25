// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..providerId = json['providerId'] as String
    ..namedId = json['namedId'] as String
    ..displayName = json['displayName'] as String
    ..avatarUrl = json['avatarUrl'] as String
    ..providerName = json['providerName'] as String
    ..emailAddress = json['emailAddress'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'providerId': instance.providerId,
      'namedId': instance.namedId,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'providerName': instance.providerName,
      'emailAddress': instance.emailAddress
    };
