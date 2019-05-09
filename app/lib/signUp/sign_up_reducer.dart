import 'package:kenpotatakai/redux/validation/validation_actions.dart';
import 'package:kenpotatakai/screens.dart';
import 'package:kenpotatakai/signUp/sign_up_actions.dart';
import 'package:kenpotatakai/signUp/sign_up_state.dart';
import 'package:redux/redux.dart';

final signUpReducer = combineReducers<SignUpState>([
  TypedReducer<SignUpState, SignUpAtProviderAction>(_signUpAt),
  TypedReducer<SignUpState, SignedUpAtProviderAction>(_signedUpAt),
  TypedReducer<SignUpState, ProviderBasedProfileReceivedAction>(_providerBasedProfileReceived),
  TypedReducer<SignUpState, NonEmptyValidationResultAction>(_displayNameValidated),
  TypedReducer<SignUpState, EmailAddressValidationResultAction>(_emailAddressValidated),
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

SignUpState _displayNameValidated(SignUpState state, NonEmptyValidationResultAction action) {
  if (action.screen == Screen.createProfile && action.propertyKey == SignUpPropertyKeys.displayName) {
    return state.copyWith(displayName: action.value, isDisplayNameValid: action.isValid);
  }

  return state;
}

SignUpState _emailAddressValidated(SignUpState state, EmailAddressValidationResultAction action) {
  if (action.screen == Screen.createProfile && action.propertyKey == SignUpPropertyKeys.emailAddress) {
    return state.copyWith(emailAddress: action.emailAddress, isEmailAddressValid: action.isValid);
  }

  return state;
}
