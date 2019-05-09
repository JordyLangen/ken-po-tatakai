import 'dart:async';
import 'package:kenpotatakai/redux/validation/validation_middleware.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:kenpotatakai/redux/app_state.dart';
import 'package:kenpotatakai/redux/app_reducer.dart';

Future<Store<AppState>> createStore() async {
  return Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [thunkMiddleware, ValidationMiddleware()]
  );
}
