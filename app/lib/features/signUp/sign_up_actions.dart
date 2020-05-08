import 'dart:async';

import 'package:kenpotatakai/api/api_models.dart';
import 'package:kenpotatakai/api/kenpotatakai_api_client.dart';
import 'package:kenpotatakai/features/auth/auth_actions.dart';
import 'package:kenpotatakai/features/auth/token_response.dart';
import 'package:kenpotatakai/features/auth/user.dart';
import 'package:kenpotatakai/features/signUp/sign_up_state.dart';
import 'package:kenpotatakai/redux/app_state.dart';
import 'package:kenpotatakai/redux/validation/validation_actions.dart';
import 'package:kenpotatakai/screens.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:meta/meta.dart';

@immutable
class SignUpAtProviderAction {
  final SignUpProvider provider;

  SignUpAtProviderAction(this.provider);
}

@immutable
class SignedUpAtProviderAction {
  final TokenResponse tokenResponse;

  SignedUpAtProviderAction(this.tokenResponse);
}

@immutable
class ProviderBasedProfileReceivedAction {
  final GetProviderBasedProfileResponse response;

  ProviderBasedProfileReceivedAction(this.response);
}

@immutable
class StartedResolvingProviderBasedProfileOrUserAction {

}

ThunkAction<AppState> getProviderBasedProfileOrUser(Completer completer) {
  return (Store<AppState> store) async {
    var client = KenpotatakaiApiClient(store.state.signUpState.authenticationToken);

    var profile = await client.getProviderBasedProfile();
    var existingUserResponse = await client.getUser(profile.providerId);

    if (existingUserResponse != null) {
      var user = User.create(
          existingUserResponse.id,
          existingUserResponse.providerId,
          existingUserResponse.platformId,
          existingUserResponse.displayName,
          existingUserResponse.avatarUrl,
          existingUserResponse.providerName,
          existingUserResponse.emailAddress);

      store.dispatch(UserRegistered(user));
      completer.complete(user);
    } else {
      store.dispatch(ProviderBasedProfileReceivedAction(profile));
      store.dispatch(ValidateEmailAddress(Screen.createProfile, SignUpPropertyKeys.emailAddress, profile.emailAddress));
      store.dispatch(ValidateNonEmpty(Screen.createProfile, SignUpPropertyKeys.displayName, profile.displayName));
      completer.complete(profile);
    }
  };
}

ThunkAction<AppState> registerUser(String providerId, String displayName, String emailAddress, String avatarUrl) {
  return (Store<AppState> store) async {
    var client = KenpotatakaiApiClient(store.state.signUpState.authenticationToken);
    var registerUserRequest = RegisterUserRequest(
        providerId: providerId, emailAddress: emailAddress, avatarUrl: avatarUrl, displayName: displayName);

    var registerUserResponse = await client.registerUser(registerUserRequest);

    var user = User.create(
        registerUserResponse.userId,
        registerUserResponse.providerId,
        registerUserResponse.platformId,
        registerUserResponse.displayName,
        registerUserResponse.avatarUrl,
        registerUserResponse.providerName,
        registerUserResponse.emailAddress);

    store.dispatch(UserRegistered(user));
  };
}
