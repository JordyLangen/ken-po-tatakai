// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpState _$SignUpStateFromJson(Map<String, dynamic> json) {
  return SignUpState(
    provider: _$enumDecodeNullable(_$SignUpProviderEnumMap, json['provider']),
    status: _$enumDecodeNullable(_$SignUpStatusEnumMap, json['status']),
    displayName: json['displayName'] as String,
    authenticationToken: json['authenticationToken'] as String,
    emailAddress: json['emailAddress'] as String,
    avatarUrl: json['avatarUrl'] as String,
    isLoading: json['isLoading'] as bool,
    providerId: json['providerId'] as String,
    isDisplayNameValid: json['isDisplayNameValid'] as bool,
    isEmailAddressValid: json['isEmailAddressValid'] as bool,
  );
}

Map<String, dynamic> _$SignUpStateToJson(SignUpState instance) =>
    <String, dynamic>{
      'provider': _$SignUpProviderEnumMap[instance.provider],
      'status': _$SignUpStatusEnumMap[instance.status],
      'authenticationToken': instance.authenticationToken,
      'isLoading': instance.isLoading,
      'displayName': instance.displayName,
      'emailAddress': instance.emailAddress,
      'avatarUrl': instance.avatarUrl,
      'providerId': instance.providerId,
      'isDisplayNameValid': instance.isDisplayNameValid,
      'isEmailAddressValid': instance.isEmailAddressValid,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$SignUpProviderEnumMap = {
  SignUpProvider.none: 'none',
  SignUpProvider.twitter: 'twitter',
};

const _$SignUpStatusEnumMap = {
  SignUpStatus.selectingProvider: 'selectingProvider',
  SignUpStatus.authenticatingAtProvider: 'authenticatingAtProvider',
  SignUpStatus.retrievingProfile: 'retrievingProfile',
  SignUpStatus.profileReceived: 'profileReceived',
};
