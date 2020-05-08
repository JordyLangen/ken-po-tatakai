import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kenpotatakai/api/kenpotatakai_api_client.dart';
import 'package:kenpotatakai/app_routes.dart';
import 'package:kenpotatakai/features/auth/user.dart';
import 'package:kenpotatakai/redux/app_state.dart';
import 'package:kenpotatakai/widgets/full_screen_loading_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../sign_up_view_model.dart';

class SignUpAtProviderScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpAtProviderScreenState();
  }
}

class _SignUpAtProviderScreenState extends State<SignUpAtProviderScreen> {
  SignUpViewModel _signUpViewModel;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, SignUpViewModel>(
      converter: (store) => SignUpViewModel.fromStore(store),
      builder: (context, viewModel) => _build(context, viewModel),
    );
  }

  Widget _build(BuildContext context, SignUpViewModel viewModel) {
    _signUpViewModel = viewModel;

    if (viewModel.isLoading) {
      return FullScreenLoadingIndicator();
    }

    return WebView(
      initialUrl: viewModel.providerSignUpEndpoint,
      javascriptMode: JavascriptMode.unrestricted,
      onPageFinished: (String page) async {
        await handlePageLoaded(page);
      },
    );
  }

  Widget _buildProviderLogoContainer(String providerName) {
    return Container(
      color: Color(0xFF00acee),
      child: Center(
        child: Hero(
          tag: providerName,
          child: Icon(
            FontAwesomeIcons.twitter,
            color: Colors.white,
            size: 64.0,
          ),
        ),
      ),
    );
  }

  Future<void> handlePageLoaded(String url) async {
    if (url.startsWith(KenpotatakaiApiClient.AuthSignUpDoneEndpoint)) {
      var userOrProfile = await _signUpViewModel.signedUpAt(url);
      if (userOrProfile is User) {
        await Navigator.pushNamedAndRemoveUntil(context, Routes.Profile, (route) => false);
      } else {
        await Navigator.popAndPushNamed(context, Routes.SignUpCreateProfile);
      }
    }
  }
}
