import 'package:kenpotatakai/signUp/sign_up_actions.dart';
import 'package:kenpotatakai/signUp/sign_up_state.dart';
import 'package:redux/redux.dart';

final signUpReducer = combineReducers<SignUpState>([
  TypedReducer<SignUpState, SignUpAtProviderAction>(_signUpAt)
]);

SignUpState _signUpAt(SignUpState state, SignUpAtProviderAction action) {
  return state.copyWith(provider: action.provider);
}
