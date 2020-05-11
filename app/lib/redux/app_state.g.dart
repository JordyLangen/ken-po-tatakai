// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(
    authState: json['authState'] == null
        ? null
        : AuthState.fromJson(json['authState'] as Map<String, dynamic>),
    signUpState: json['signUpState'] == null
        ? null
        : SignUpState.fromJson(json['signUpState'] as Map<String, dynamic>),
    profileState: json['profileState'] == null
        ? null
        : ProfileState.fromJson(json['profileState'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'authState': instance.authState,
      'signUpState': instance.signUpState,
      'profileState': instance.profileState,
    };
