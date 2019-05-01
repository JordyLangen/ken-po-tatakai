import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kenpotatakai/app_colors.dart';
import 'package:kenpotatakai/app_routes.dart';
import 'package:kenpotatakai/extensions/string_extensions.dart';
import 'package:kenpotatakai/redux/app_state.dart';
import 'package:kenpotatakai/signUp/sign_up_provider.dart';
import 'package:kenpotatakai/signUp/sign_up_view_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    var body = _buildProviderOverview(viewModel);

    return Scaffold(backgroundColor: AppColors.primaryColor, body: body);
  }

  Widget _buildProviderOverview(SignUpViewModel viewModel) {
    final twitterRow = _buildProvider(
        SignUpProvider.TWITTER, FontAwesomeIcons.twitter, viewModel);

    return Center(
      child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: [
            Text('Welcome to Kenpotatakai!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            SizedBox(height: 16.0),
            Text(
                'Use any of the providers listed below to create an account so you can use this app.',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center),
            SizedBox(height: 32.0),
            twitterRow
          ]),
    );
  }

  Widget _buildProvider(
      SignUpProvider provider, IconData icon, SignUpViewModel viewModel) {
    var providerName = capitalize(provider.toString().split('.').last);
    final text = 'Sign up with ' + providerName;

    return ClipRRect(
        borderRadius: BorderRadius.circular(32.0),
        child: FlatButton(
            padding: EdgeInsets.all(0),
            child: Container(
                padding: EdgeInsets.all(4),
                color: AppColors.accentColor,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(right: 16.0, top: 8.0, bottom: 8.0),
                          child: Hero(
                              tag: providerName.toLowerCase(),
                              child: Icon(
                                icon,
                                color: Colors.white,
                              ))),
                      Text(text, style: TextStyle(color: Colors.white))
                    ])),
            onPressed: () {
              viewModel.signUpAt(provider);
              Navigator.pushNamed(context, Routes.SignUpAtProvider);
            }));
  }
}
