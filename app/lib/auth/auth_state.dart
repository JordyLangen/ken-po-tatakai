import 'package:json_annotation/json_annotation.dart';
import 'package:kenpotatakai/auth/user.dart';
import 'package:meta/meta.dart';

part 'auth_state.g.dart';

@immutable
@JsonSerializable()
class AuthState {
  final String accessToken;
  final User user;

  AuthState({@required this.accessToken, @required this.user});

  factory AuthState.initial() {
    return new AuthState(accessToken: null, user: null);
  }

  factory AuthState.fromJson(Map<String, dynamic> json) => _$AuthStateFromJson(json);

  Map<String, dynamic> toJson() => _$AuthStateToJson(this);
}
