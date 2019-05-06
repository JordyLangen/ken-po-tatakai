import 'package:kenpotatakai/api/api_models.dart';
import 'package:kenpotatakai/api/kenpotatakai_api_client.dart';
import 'package:kenpotatakai/auth/auth_actions.dart';
import 'package:kenpotatakai/auth/token_response.dart';
import 'package:kenpotatakai/redux/app_state.dart';
import 'package:kenpotatakai/signUp/sign_up_state.dart';
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

ThunkAction<AppState> getProviderBasedProfileOrUser() {
  return (Store<AppState> store) async {
    var client = KenpotatakaiApiClient(store.state.signUpState.authenticationToken);
    var profile = await client.getProviderBasedProfile();

    var existingUser = await client.getUser(profile.providerId);

    if (existingUser != null) {
      store.dispatch(UserRegisteredAction(existingUser));
    } else {
      store.dispatch(ProviderBasedProfileReceivedAction(profile));
    }
  };
}
