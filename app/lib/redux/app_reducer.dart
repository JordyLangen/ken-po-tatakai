import 'package:kenpotatakai/features/auth/auth_reducer.dart';
import 'package:kenpotatakai/features/signUp/sign_up_reducer.dart';
import 'package:kenpotatakai/redux/app_state.dart';

AppState appReducer(AppState state, dynamic action) => new AppState(
    authState: authReducer(state.authState, action), signUpState: signUpReducer(state.signUpState, action));
