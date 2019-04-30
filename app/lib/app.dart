import 'package:flutter/material.dart';
import 'package:kenpotatakai/app_colors.dart';
import 'package:kenpotatakai/redux/app_state.dart';
import 'package:kenpotatakai/signUp/sign_up_screen.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class App extends StatefulWidget {
  final Store<AppState> store;
  final navigatorKey = GlobalKey<NavigatorState>();

  App(this.store);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
        store: widget.store,
        child: new MaterialApp(
            theme: new ThemeData(
                brightness: Brightness.dark,
                primaryColor: AppColors.primaryColor,
                accentColor: AppColors.accentColor),
            home: SignUpScreen(),
            navigatorKey: widget.navigatorKey));
  }
}
