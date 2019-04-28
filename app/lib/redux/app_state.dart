import 'package:kenpotatakai/auth/auth_state.dart';
import 'package:kenpotatakai/signUp/sign_up_state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final AuthState authState;
  final SignUpState signUpState;

  AppState({@required this.authState, @required this.signUpState});

  factory AppState.initial() {
    return new AppState(
        authState: AuthState.initial(), signUpState: SignUpState.initial());
  }
}
