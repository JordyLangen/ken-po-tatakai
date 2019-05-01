import 'package:kenpotatakai/signUp/sign_up_actions.dart';
import 'package:kenpotatakai/signUp/sign_up_state.dart';
import 'package:redux/redux.dart';

final signUpReducer = combineReducers<SignUpState>([
  TypedReducer<SignUpState, SignUpAtProviderAction>(_signUpAt),
  TypedReducer<SignUpState, SignUpPageLoadedAction>(_signUpPageLoaded)
]);

SignUpState _signUpAt(SignUpState state, SignUpAtProviderAction action) {
  return state.copyWith(provider: action.provider, isLoading: true);
}

SignUpState _signUpPageLoaded(SignUpState state, SignUpPageLoadedAction action) {
  return state.copyWith(isLoading: false);
}
