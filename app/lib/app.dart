import 'package:flutter/material.dart';
import 'package:kenpotatakai/app_colors.dart';
import 'package:kenpotatakai/app_routes.dart';
import 'package:kenpotatakai/features/profile/profile_screen.dart';
import 'package:kenpotatakai/redux/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'features/signUp/create_profile_screen.dart';
import 'features/signUp/sign_up_at_provider_screen.dart';
import 'features/signUp/sign_up_screen.dart';

class App extends StatefulWidget {
  final Store<AppState> store;

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
                accentColor: AppColors.accentColor,
                fontFamily: 'Raleway'),
            home: widget.store.state.authState.user != null ? ProfileScreen() : SignUpScreen(),
            initialRoute: widget.store.state.authState.user != null ? Routes.Profile : Routes.SignUp,
            routes: {
              Routes.SignUp: (context) => SignUpScreen(),
              Routes.SignUpAtProvider: (context) => SignUpAtProviderScreen(),
              Routes.SignUpCreateProfile: (context) => CreateProfileScreen(),
              Routes.Profile: (content) => ProfileScreen()
            }));
  }
}
