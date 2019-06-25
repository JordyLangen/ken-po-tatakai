import 'dart:async';
import 'package:kenpotatakai/redux/validation/validation_middleware.dart';
import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:kenpotatakai/redux/app_state.dart';
import 'package:kenpotatakai/redux/app_reducer.dart';

Future<Store<AppState>> createStore() async {
  var persistor = await _createPersistor();

  return Store<AppState>(appReducer,
      initialState: AppState.initial(),
      middleware: [persistor.createMiddleware(), thunkMiddleware, ValidationMiddleware()]);
}

Future<Persistor<AppState>> _createPersistor() async {
  var persistor = Persistor<AppState>(
      storage: FlutterStorage(),
      serializer: JsonSerializer<AppState>((json) {
        return AppState.fromJson(json);
      }));

  await persistor.load();
  return persistor;
}
