import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

    return Stack(
      children: [
        _buildProviderLogoContainer(viewModel, providerName),
        _buildWebView(viewModel, providerName)
      ],
    );
  }

  Widget _buildProviderLogoContainer(
      SignUpViewModel viewModel, String providerName) {
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

  Widget _buildWebView(SignUpViewModel viewModel, String providerName) {
    return AnimatedOpacity(
        opacity: viewModel.isLoading ? 0 : 1,
        duration: Duration(milliseconds: 200),
        child: Container(
            color: AppColors.primaryColor,
            child: WebView(
                initialUrl:
                    '${KenpotatakaiApi.AuthSignUpEndpoint}/$providerName',
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (url) =>
                    this.handlePageLoaded(viewModel, url))));
  }

  void handlePageLoaded(SignUpViewModel viewModel, String url) {
    viewModel.signUpPageLoaded();
    print(url);
  }
}
