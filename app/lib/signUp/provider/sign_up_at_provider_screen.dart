import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kenpotatakai/api/kenpotatakai_api_client.dart';
import 'package:kenpotatakai/app_routes.dart';
import 'package:kenpotatakai/redux/app_state.dart';
import 'package:kenpotatakai/signUp/sign_up_view_model.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class SignUpAtProviderScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpAtProviderScreenState();
  }
}

class _SignUpAtProviderScreenState extends State<SignUpAtProviderScreen> {
  final _webviewController = FlutterWebviewPlugin();
  SignUpViewModel _signUpViewModel;
  StreamSubscription<String> _onUrlChanged;

  @override
  void initState() {
    super.initState();

    _onUrlChanged = _webviewController.onUrlChanged.listen((String url) {
      handlePageLoaded(url);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _onUrlChanged.cancel();
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

    return WebviewScaffold(
      url: viewModel.providerSignUpEndpoint,
      withZoom: true,
      withLocalStorage: true,
      withJavascript: true,
      hidden: true,
      initialChild: _buildProviderLogoContainer(viewModel.providerName),
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

  void handlePageLoaded(String url) {
    if (url.startsWith(KenpotatakaiApiClient.AuthSignUpDoneEndpoint)) {
      _signUpViewModel.signedUpAt(url);
      Navigator.popAndPushNamed(context, Routes.SignUpCreateProfile);
    }
  }
}
