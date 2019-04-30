import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kenpotatakai/api/kenpotatakai_api.dart';
import 'package:kenpotatakai/app_colors.dart';
import 'package:kenpotatakai/redux/app_state.dart';
import 'package:kenpotatakai/signUp/sign_up_view_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SignUpAtProviderScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpAtProviderScreenState();
  }
}

class _SignUpAtProviderScreenState extends State<SignUpAtProviderScreen> {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, SignUpViewModel>(
      converter: (store) => SignUpViewModel.fromStore(store),
      builder: (context, viewModel) => _build(context, viewModel),
    );
  }

  Widget _build(BuildContext context, SignUpViewModel viewModel) {
    var body = _buildProviderLoginView(viewModel);

    return Scaffold(backgroundColor: AppColors.primaryColor, body: body);
  }

  Widget _buildProviderLoginView(SignUpViewModel viewModel) {
    var providerName =
    viewModel.selectedProvider.toString().split('.').last.toLowerCase();

    return Container(
        color: AppColors.primaryColor,
        child: WebView(
            initialUrl: '${KenpotatakaiApi.authSignUpEndpoint}/$providerName',
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (url) => print(url)));
  }
}