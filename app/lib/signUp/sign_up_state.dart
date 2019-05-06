import 'package:meta/meta.dart';

enum SignUpProvider { none, twitter }

enum SignUpStatus { selectingProvider, authenticatingAtProvider, retrievingProfile, profileReceived }

@immutable
class SignUpState {
  final SignUpProvider provider;
  final SignUpStatus status;
  final String authenticationToken;

  final String displayName;
  final String emailAddress;
  final String avatarUrl;
  final String providerId;

  SignUpState({
    @required this.provider,
    @required this.status,
    @required this.displayName,
    @required this.authenticationToken,
    @required this.emailAddress,
    @required this.avatarUrl,
    @required this.providerId,
  });

  factory SignUpState.initial() {
    return new SignUpState(
        provider: SignUpProvider.none,
        status: SignUpStatus.selectingProvider,
        displayName: null,
        authenticationToken: null,
        providerId: null,
        avatarUrl: null,
        emailAddress: null);
  }

  SignUpState copyWith(
      {SignUpProvider provider,
      SignUpStatus status,
      String displayName,
      String emailAddress,
      String avatarUrl,
      String providerId,
      String authenticationToken,
      bool isLoading,
      bool isAuthenticated}) {
    return new SignUpState(
        provider: provider ?? this.provider,
        status: status ?? this.status,
        authenticationToken: authenticationToken ?? this.authenticationToken,
        displayName: displayName ?? this.displayName,
        providerId: providerId ?? this.providerId,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        emailAddress: emailAddress ?? this.emailAddress);
  }
}
