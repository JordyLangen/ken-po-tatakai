import 'package:redux/redux.dart';

import 'auth_actions.dart';
import 'auth_state.dart';

final authReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, UserRegistered>(_userRegistered),
]);

AuthState _userRegistered(AuthState state, UserRegistered action) {
  return state.copyWith(user: action.user);
}
