import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.g.dart';

enum SignUpProvider { none, twitter }

enum SignUpStatus { selectingProvider, authenticatingAtProvider, retrievingProfile, profileReceived }

enum SignUpPropertyKeys { displayName, emailAddress }

@immutable
@JsonSerializable()
class SignUpState {
  final SignUpProvider provider;
  final SignUpStatus status;
  final String authenticationToken;

  final String displayName;
  final String emailAddress;
  final String avatarUrl;
  final String providerId;

  final bool isDisplayNameValid;
  final bool isEmailAddressValid;

  SignUpState({
    @required this.provider,
    @required this.status,
    @required this.displayName,
    @required this.authenticationToken,
    @required this.emailAddress,
    @required this.avatarUrl,
    @required this.providerId,
    @required this.isDisplayNameValid,
    @required this.isEmailAddressValid,
  });

  factory SignUpState.initial() {
    return new SignUpState(
        provider: SignUpProvider.none,
        status: SignUpStatus.selectingProvider,
        displayName: null,
        authenticationToken: null,
        providerId: null,
        avatarUrl: null,
        emailAddress: null,
        isDisplayNameValid: false,
        isEmailAddressValid: false);
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
      bool isAuthenticated,
      bool isDisplayNameValid,
      bool isEmailAddressValid}) {
    return new SignUpState(
        provider: provider ?? this.provider,
        status: status ?? this.status,
        authenticationToken: authenticationToken ?? this.authenticationToken,
        displayName: displayName ?? this.displayName,
        providerId: providerId ?? this.providerId,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        emailAddress: emailAddress ?? this.emailAddress,
        isDisplayNameValid: isDisplayNameValid ?? this.isDisplayNameValid,
        isEmailAddressValid: isEmailAddressValid ?? this.isEmailAddressValid);
  }

  factory SignUpState.fromJson(Map<String, dynamic> json) => _$SignUpStateFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpStateToJson(this);
}
