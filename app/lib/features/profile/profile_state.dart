import 'package:json_annotation/json_annotation.dart';
import 'package:kenpotatakai/features/profile/user_statistics.dart';
import 'package:meta/meta.dart';

part 'profile_state.g.dart';

@immutable
@JsonSerializable()
class ProfileState {
  final UserStatistics userStatistics;

  ProfileState({@required this.userStatistics});

  factory ProfileState.initial() {
    return new ProfileState(userStatistics: UserStatistics.empty());
  }

  factory ProfileState.fromJson(Map<String, dynamic> json) => _$ProfileStateFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileStateToJson(this);
}
