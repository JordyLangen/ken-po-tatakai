import 'dart:async';
import 'dart:convert';

import 'package:kenpotatakai/api/kenpotatakai_api_client.dart';
import 'package:kenpotatakai/features/auth/token_response.dart';
import 'package:kenpotatakai/features/signUp/sign_up_actions.dart';
import 'package:kenpotatakai/features/signUp/sign_up_state.dart';
import 'package:kenpotatakai/redux/app_state.dart';
import 'package:kenpotatakai/redux/validation/validation_actions.dart';
import 'package:kenpotatakai/screens.dart';
import 'package:redux/redux.dart';

class SignUpViewModel {
  final SignUpProvider selectedProvider;
  final SignUpStatus status;
  final String providerId;
  final String displayName;
  final String emailAddress;
  final String avatarUrl;
  final bool isLoading;
  final bool isDisplayNameValid;
  final bool isEmailAddressValid;

  bool get didSelectProvider => selectedProvider != null && selectedProvider != SignUpProvider.none;

  String get providerName => selectedProvider.toString().split('.').last.toLowerCase();

  String get providerSignUpEndpoint => '${KenpotatakaiApiClient.AuthSignUpEndpoint}/$providerName';

  bool get canBeSubmitted => isDisplayNameValid && isEmailAddressValid;

  final Function(SignUpProvider) signUpAt;
  final Function(String) signedUpAt;
  final Function(String) validateEmailAddress;
  final Function(String) validateDisplayName;
  final Function() register;

  SignUpViewModel(
      {this.selectedProvider,
      this.displayName,
      this.status,
      this.providerId,
      this.emailAddress,
      this.avatarUrl,
      this.isLoading,
      this.signUpAt,
      this.signedUpAt,
      this.isDisplayNameValid,
      this.isEmailAddressValid,
      this.validateEmailAddress,
      this.validateDisplayName,
      this.register});

  factory SignUpViewModel.fromStore(Store<AppState> store) {
    final signUpState = store.state.signUpState;

    return new SignUpViewModel(
        displayName: signUpState.displayName,
        status: signUpState.status,
        providerId: signUpState.providerId,
        avatarUrl: signUpState.avatarUrl,
        isLoading: signUpState.isLoading ?? false,
        emailAddress: signUpState.emailAddress,
        selectedProvider: signUpState.provider,
        isDisplayNameValid: signUpState.isDisplayNameValid,
        isEmailAddressValid: signUpState.isEmailAddressValid,
        signUpAt: (provider) {
          store.dispatch(SignUpAtProviderAction(provider));
        },
        signedUpAt: (String urlWithToken) async {
          var tokenResponseBody = Uri.decodeComponent(urlWithToken.split('#token=').last);
          var tokenResponseMap = jsonDecode(tokenResponseBody);
          var tokenResponse = TokenResponse.fromJson(tokenResponseMap);
          store.dispatch(SignedUpAtProviderAction(tokenResponse));
          store.dispatch(StartedResolvingProviderBasedProfileOrUserAction());

          var completer = Completer();
          store.dispatch(getProviderBasedProfileOrUser(completer));
          return completer.future;
        },
        validateDisplayName: (String displayName) {
          store.dispatch(ValidateNonEmpty(Screen.createProfile, SignUpPropertyKeys.displayName, displayName));
        },
        validateEmailAddress: (String emailAddress) {
          store.dispatch(ValidateEmailAddress(Screen.createProfile, SignUpPropertyKeys.emailAddress, emailAddress));
        },
        register: () {
          store.dispatch(registerUser(
              signUpState.providerId, signUpState.displayName, signUpState.emailAddress, signUpState.avatarUrl));
        });
  }
}
