import 'package:kenpotatakai/auth/auth_actions.dart';
import 'package:kenpotatakai/auth/auth_state.dart';
import 'package:redux/redux.dart';

final authReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, UserRegisteredAction>(_userRegistered),
]);

AuthState _userRegistered(AuthState state, UserRegisteredAction action) {
  // TODO:
  return state;
}
