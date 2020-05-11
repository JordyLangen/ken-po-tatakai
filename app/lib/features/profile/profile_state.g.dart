// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileState _$ProfileStateFromJson(Map<String, dynamic> json) {
  return ProfileState(
    userStatistics: json['userStatistics'] == null
        ? null
        : UserStatistics.fromJson(
            json['userStatistics'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProfileStateToJson(ProfileState instance) =>
    <String, dynamic>{
      'userStatistics': instance.userStatistics,
    };
