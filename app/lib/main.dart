import 'package:flutter/material.dart';
import 'package:kenpotatakai/app.dart';
import 'package:kenpotatakai/redux/store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var store = await createStore();
  runApp(App(store));
}
