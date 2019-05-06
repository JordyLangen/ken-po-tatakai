import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:kenpotatakai/app_colors.dart';
import 'package:kenpotatakai/redux/app_state.dart';
import 'package:kenpotatakai/signUp/sign_up_state.dart';
import 'package:kenpotatakai/signUp/sign_up_view_model.dart';

class CreateProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateProfileScreenState();
  }
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, SignUpViewModel>(
      converter: (store) => SignUpViewModel.fromStore(store),
      builder: (context, viewModel) => _build(context, viewModel),
      onInitialBuild: (viewModel) => viewModel.getProviderBasedProfile(),
    );
  }

  Widget _build(BuildContext context, SignUpViewModel viewModel) {
    if (viewModel.status == SignUpStatus.retrievingProfile) {
      return Scaffold(
          body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ));
    } else {
      var avatar = CircleAvatar(
        backgroundImage: NetworkImage(viewModel.avatarUrl),
        radius: 64.0,
      );

      var displayNameController = TextEditingController(text: viewModel.displayName);
      var displayNameField = TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Display name",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        controller: displayNameController,
      );

      var emailAddressController = TextEditingController(text: viewModel.emailAddress);
      var emailAddressField = TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Email address",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        controller: emailAddressController,
      );

      return Scaffold(
          body: Center(
              child: Container(
        color: AppColors.primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              avatar,
              SizedBox(height: 24.0),
              displayNameField,
              SizedBox(height: 24.0),
              emailAddressField
            ],
          ),
        ),
      )));
    }
  }
}
