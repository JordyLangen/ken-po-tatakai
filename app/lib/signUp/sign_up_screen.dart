import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kenpotatakai/extensions/string_extensions.dart';
import 'package:kenpotatakai/redux/app_state.dart';
import 'package:kenpotatakai/signUp/sign_up_provider.dart';
import 'package:kenpotatakai/signUp/sign_up_view_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, SignUpViewModel>(
      converter: (store) => SignUpViewModel.fromStore(store),
      builder: (context, viewModel) => _build(context, viewModel),
    );
  }

  Widget _build(BuildContext context, SignUpViewModel viewModel) {
    var body = viewModel.didSelectProvider
        ? _buildProviderLoginView(viewModel)
        : _buildProviderOverview(viewModel);

    return Scaffold(backgroundColor: Color(0xFF0A1026), body: body);
  }

  Widget _buildProviderLoginView(SignUpViewModel viewModel) {
    var providerName =
        viewModel.selectedProvider.toString().split('.').last.toLowerCase();

    return Container(
      color: Color(0xFF0A1026),
        child: WebView(
      initialUrl: 'https://ken-po-tatakai.azurewebsites.net/.auth/login/' +
          providerName,
      javascriptMode: JavascriptMode.unrestricted,
      onPageFinished: (url) => print(url)
    ));
  }

  Widget _buildProviderOverview(SignUpViewModel viewModel) {
    final twitterRow = _buildProvider(
        SignUpProvider.TWITTER, FontAwesomeIcons.twitter, viewModel);
    final facebookRow = _buildProvider(
        SignUpProvider.FACEBOOK, FontAwesomeIcons.facebook, viewModel);

    return Center(
      child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: [
            Text('Choose a provider',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            SizedBox(height: 16.0),
            Text(
                'Use any of the providers listed below to create an account so you can use this app.',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center),
            SizedBox(height: 32.0),
            twitterRow,
            SizedBox(height: 16.0),
            facebookRow
          ]),
    );
  }

  Widget _buildProvider(
      SignUpProvider provider, IconData icon, SignUpViewModel viewModel) {
    var providerName = capitalize(provider.toString().split('.').last);
    final text = 'Sign up with ' + providerName;

    return FlatButton(
        padding: EdgeInsets.all(0),
        child: Container(
            padding: EdgeInsets.all(4),
            color: Color(0xFF2561DD),
            child: Row(mainAxisSize: MainAxisSize.max, children: [
              Padding(
                  padding: EdgeInsets.all(16),
                  child: Icon(
                    icon,
                    color: Colors.white,
                  )),
              Text(text, style: TextStyle(color: Colors.white))
            ])),
        onPressed: () {
          viewModel.startSignUp(provider);
        });
  }
}
