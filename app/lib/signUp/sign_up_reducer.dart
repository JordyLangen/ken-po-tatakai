import 'package:kenpotatakai/signUp/sign_up_actions.dart';
import 'package:kenpotatakai/signUp/sign_up_state.dart';
import 'package:redux/redux.dart';

final signUpReducer = combineReducers<SignUpState>([
  TypedReducer<SignUpState, StartSignUpAction>(_startSignUp)
]);

SignUpState _startSignUp(SignUpState state, StartSignUpAction action) {
  return state.copyWith(provider: action.provider);
}
