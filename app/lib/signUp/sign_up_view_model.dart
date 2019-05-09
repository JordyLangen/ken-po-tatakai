import 'dart:convert';

import 'package:kenpotatakai/api/kenpotatakai_api_client.dart';
import 'package:kenpotatakai/auth/token_response.dart';
import 'package:kenpotatakai/redux/app_state.dart';
import 'package:kenpotatakai/redux/validation/validation_actions.dart';
import 'package:kenpotatakai/screens.dart';
import 'package:kenpotatakai/signUp/sign_up_actions.dart';
import 'package:kenpotatakai/signUp/sign_up_state.dart';
import 'package:redux/redux.dart';

class SignUpViewModel {
  final SignUpProvider selectedProvider;
  final SignUpStatus status;
  final String displayName;
  final String emailAddress;
  final String avatarUrl;
  final bool isDisplayNameValid;
  final bool isEmailAddressValid;

  bool get didSelectProvider => selectedProvider != null && selectedProvider != SignUpProvider.none;

  String get providerName => selectedProvider.toString().split('.').last.toLowerCase();

  String get providerSignUpEndpoint => '${KenpotatakaiApiClient.AuthSignUpEndpoint}/$providerName';

  bool get canBeSubmitted => isDisplayNameValid && isEmailAddressValid;

  final Function(SignUpProvider) signUpAt;
  final Function(String) signedUpAt;
  final Function() getProviderBasedProfile;
  final Function(String) validateEmailAddress;
  final Function(String) validateDisplayName;

  SignUpViewModel(
      {this.selectedProvider,
      this.displayName,
      this.status,
      this.emailAddress,
      this.avatarUrl,
      this.signUpAt,
      this.signedUpAt,
      this.getProviderBasedProfile,
      this.isDisplayNameValid,
      this.isEmailAddressValid,
      this.validateEmailAddress,
      this.validateDisplayName});

  factory SignUpViewModel.fromStore(Store<AppState> store) {
    final signUpState = store.state.signUpState;

    return new SignUpViewModel(
        displayName: signUpState.displayName,
        status: signUpState.status,
        avatarUrl: signUpState.avatarUrl,
        emailAddress: signUpState.emailAddress,
        selectedProvider: signUpState.provider,
        isDisplayNameValid: signUpState.isDisplayNameValid,
        isEmailAddressValid: signUpState.isEmailAddressValid,
        signUpAt: (provider) {
          store.dispatch(SignUpAtProviderAction(provider));
        },
        signedUpAt: (url) {
          var tokenResponseBody = Uri.decodeComponent(url.split('#token=').last);
          var tokenResponseMap = jsonDecode(tokenResponseBody);
          var tokenResponse = TokenResponse.fromJson(tokenResponseMap);
          store.dispatch(SignedUpAtProviderAction(tokenResponse));
        },
        getProviderBasedProfile: () {
          store.dispatch(getProviderBasedProfileOrUser());
        },
        validateDisplayName: (String displayName) {
          store.dispatch(ValidateNonEmpty(Screen.createProfile, SignUpPropertyKeys.displayName, displayName));
        },
        validateEmailAddress: (String emailAddress) {
          store.dispatch(ValidateEmailAddress(Screen.createProfile, SignUpPropertyKeys.emailAddress, emailAddress));
        });
  }
}
