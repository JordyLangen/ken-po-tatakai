import 'package:json_annotation/json_annotation.dart';
import 'package:kenpotatakai/features/auth/auth_state.dart';
import 'package:kenpotatakai/features/signUp/sign_up_state.dart';
import 'package:kenpotatakai/features/profile/profile_state.dart';
import 'package:meta/meta.dart';

part 'app_state.g.dart';

@immutable
@JsonSerializable()
class AppState {
  final AuthState authState;
  final SignUpState signUpState;
  final ProfileState profileState;

  AppState({@required this.authState, @required this.signUpState, @required this.profileState});

  factory AppState.initial() {
    return new AppState(
        authState: AuthState.initial(), signUpState: SignUpState.initial(), profileState: ProfileState.initial());
  }

  factory AppState.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return AppState.initial();
    }

    return _$AppStateFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}
