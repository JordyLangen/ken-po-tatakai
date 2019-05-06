import 'package:kenpotatakai/signUp/sign_up_actions.dart';
import 'package:kenpotatakai/signUp/sign_up_state.dart';
import 'package:redux/redux.dart';

final signUpReducer = combineReducers<SignUpState>([
  TypedReducer<SignUpState, SignUpAtProviderAction>(_signUpAt),
  TypedReducer<SignUpState, SignedUpAtProviderAction>(_signedUpAt),
  TypedReducer<SignUpState, ProviderBasedProfileReceivedAction>(_providerBasedProfileReceived),
]);

SignUpState _signUpAt(SignUpState state, SignUpAtProviderAction action) {
  return state.copyWith(provider: action.provider, status: SignUpStatus.authenticatingAtProvider);
}

SignUpState _signedUpAt(SignUpState state, SignedUpAtProviderAction action) {
  return state.copyWith(
      authenticationToken: action.tokenResponse.authenticationToken, status: SignUpStatus.retrievingProfile);
}

SignUpState _providerBasedProfileReceived(SignUpState state, ProviderBasedProfileReceivedAction action) {
  return state.copyWith(
      displayName: action.response.displayName,
      emailAddress: action.response.emailAddress,
      avatarUrl: action.response.avatarUrl,
      providerId: action.response.providerId,
      status: SignUpStatus.profileReceived);
}
