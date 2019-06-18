import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kenpotatakai/app_colors.dart';
import 'package:kenpotatakai/redux/app_state.dart';
import 'package:kenpotatakai/signUp/sign_up_state.dart';
import 'package:kenpotatakai/signUp/sign_up_view_model.dart';
import 'package:kenpotatakai/widgets/app_button.dart';
import 'package:kenpotatakai/widgets/full_screen_loading_indicator.dart';
import 'package:kenpotatakai/widgets/main_container.dart';

class CreateProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateProfileScreenState();
  }
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  TextEditingController _displayNameController;
  TextEditingController _emailAddressController;

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
      return FullScreenLoadingIndicator();
    } else {
      return _buildForm(viewModel);
    }
  }

  Widget _buildForm(SignUpViewModel viewModel) {
    if (_displayNameController == null) {
      _displayNameController = TextEditingController(text: viewModel.displayName);
    }

    if (_emailAddressController == null) {
      _emailAddressController = TextEditingController(text: viewModel.emailAddress);
    }

    var avatarSize = 128.0;
    var avatar = Center(
        child: Container(
            height: avatarSize,
            width: avatarSize,
            child: CircleAvatar(
              backgroundImage: NetworkImage(viewModel.avatarUrl),
              radius: avatarSize,
            )));

    var displayNameField = TextField(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Display name',
          errorText: !viewModel.isDisplayNameValid ? 'A display name is required' : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      controller: _displayNameController,
      onChanged: (displayName) {
        viewModel.validateDisplayName(displayName);
      },
    );

    var emailAddressField = TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Email address',
          errorText: !viewModel.isEmailAddressValid ? 'A valid email address is required' : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      controller: _emailAddressController,
      onChanged: (emailAddress) {
        viewModel.validateEmailAddress(emailAddress);
      },
    );

    var registerButton = AppButton(
      text: 'Sign up',
      onPressed: () {
        if (!viewModel.canBeSubmitted) {
          return null;
        }
      },
    );

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: MainContainer.primary(
        child: Center(
          child: ListView(shrinkWrap: true, padding: EdgeInsets.only(left: 24.0, right: 24.0), children: [
            Text('Create your profile',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            SizedBox(height: 24.0),
            avatar,
            SizedBox(height: 24.0),
            displayNameField,
            SizedBox(height: 24.0),
            emailAddressField,
            SizedBox(height: 24.0),
            registerButton
          ]),
        ),
      ),
    );
  }
}
