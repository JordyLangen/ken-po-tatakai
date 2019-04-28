import 'package:kenpotatakai/redux/app_state.dart';
import 'package:kenpotatakai/auth/auth_reducer.dart';
import 'package:kenpotatakai/signUp/sign_up_reducer.dart';

AppState appReducer(AppState state, dynamic action) => new AppState(
    authState: authReducer(state.authState, action),
    signUpState: signUpReducer(state.signUpState, action));
