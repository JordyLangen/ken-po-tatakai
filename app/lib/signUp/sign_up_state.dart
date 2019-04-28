import 'package:kenpotatakai/signUp/sign_up_provider.dart';
import 'package:meta/meta.dart';

@immutable
class SignUpState {
  final SignUpProvider provider;
  final String displayName;
  final String accessToken;
  final bool isLoading;
  final bool isAuthenticated;

  SignUpState({@required this.provider,
    @required this.displayName,
    @required this.accessToken,
    @required this.isLoading,
    @required this.isAuthenticated});

  factory SignUpState.initial() {
    return new SignUpState(
        provider: SignUpProvider.NONE,
        displayName: null,
        accessToken: null,
        isLoading: false,
        isAuthenticated: false);
  }

  SignUpState copyWith({SignUpProvider provider, String displayName,
    String accessToken, bool isLoading, bool isAuthenticated}) {
    return new SignUpState(
        provider: provider ?? this.provider,
        isLoading: isLoading ?? this.isLoading,
        accessToken: accessToken ?? this.accessToken,
        displayName: displayName ?? this.displayName,
        isAuthenticated: isAuthenticated ?? this.isAuthenticated
    );
  }
}
