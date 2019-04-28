import 'package:kenpotatakai/auth/user.dart';
import 'package:meta/meta.dart';

@immutable
class AuthState {
  final String accessToken;
  final User user;

  AuthState({@required this.accessToken, @required this.user});

  factory AuthState.initial() {
    return new AuthState(accessToken: null, user: null);
  }
}
