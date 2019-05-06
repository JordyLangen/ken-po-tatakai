import 'dart:convert';

import 'package:kenpotatakai/auth/token_response.dart';
import 'package:kenpotatakai/redux/app_state.dart';
import 'package:kenpotatakai/signUp/sign_up_actions.dart';
import 'package:kenpotatakai/signUp/sign_up_state.dart';
import 'package:redux/redux.dart';

class SignUpViewModel {
  final SignUpProvider selectedProvider;
  final SignUpStatus status;
  final String displayName;
  final String emailAddress;
  final String avatarUrl;

  bool get didSelectProvider => selectedProvider != null && selectedProvider != SignUpProvider.none;

  final Function(SignUpProvider) signUpAt;
  final Function(String) signedUpAt;
  final Function() getProviderBasedProfile;

  SignUpViewModel({
    this.selectedProvider,
    this.displayName,
    this.status,
    this.emailAddress,
    this.avatarUrl,
    this.signUpAt,
    this.signedUpAt,
    this.getProviderBasedProfile,
  });

  factory SignUpViewModel.fromStore(Store<AppState> store) {
    final signUpState = store.state.signUpState;

    return new SignUpViewModel(
        displayName: signUpState.displayName,
        status: signUpState.status,
        avatarUrl: signUpState.avatarUrl,
        emailAddress: signUpState.emailAddress,
        selectedProvider: signUpState.provider,
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
        });
  }
}
