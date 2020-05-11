import 'package:json_annotation/json_annotation.dart';

part 'user_statistics.g.dart';

@JsonSerializable()
class UserStatistics {
  int matchesCount;
  int matchesWonCount;
  int rank;

  UserStatistics();

  UserStatistics.empty() {
    this.matchesCount = 0;
    this.matchesWonCount = 0;
    this.rank = null;
  }

  factory UserStatistics.fromJson(Map<String, dynamic> json) => _$UserStatisticsFromJson(json);

  Map<String, dynamic> toJson() => _$UserStatisticsToJson(this);
}
