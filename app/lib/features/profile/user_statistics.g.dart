// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserStatistics _$UserStatisticsFromJson(Map<String, dynamic> json) {
  return UserStatistics()
    ..matchesCount = json['matchesCount'] as int
    ..matchesWonCount = json['matchesWonCount'] as int
    ..rank = json['rank'] as int;
}

Map<String, dynamic> _$UserStatisticsToJson(UserStatistics instance) =>
    <String, dynamic>{
      'matchesCount': instance.matchesCount,
      'matchesWonCount': instance.matchesWonCount,
      'rank': instance.rank,
    };
