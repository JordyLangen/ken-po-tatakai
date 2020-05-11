import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kenpotatakai/features/profile/profile_view_model.dart';
import 'package:kenpotatakai/redux/app_state.dart';
 import 'package:kenpotatakai/widgets/app_button.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ProfileViewModel>(
      converter: (store) => ProfileViewModel.fromStore(store),
      builder: (context, viewModel) => _build(context, viewModel),
    );
  }

  Widget _build(BuildContext context, ProfileViewModel viewModel) {
    return Scaffold(body: Container(color: Colors.black, child: _buildHeader(context, viewModel)));
  }

  Widget _buildHeader(BuildContext context, ProfileViewModel viewModel) {
    var avatarSize = 96.0;
    var avatar = Center(
        child: Container(
            height: avatarSize,
            width: avatarSize,
            child: CircleAvatar(
              backgroundImage: NetworkImage(viewModel.user.avatarUrl),
              radius: avatarSize,
            )));

    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(viewModel.user.avatarUrl),
          fit: BoxFit.cover,
        )),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),
          child: new Container(
              decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      child: avatar,
                      padding: EdgeInsets.all(18),
                    ),
                    Padding(
                      child: Text(
                        viewModel.user.displayName,
                        style: TextStyle(fontSize: 21, color: Colors.white),
                      ),
                      padding: EdgeInsets.all(18),
                    ),
                    Padding(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatistic('played', viewModel.matchesPlayed),
                          _buildStatistic('won', viewModel.matchesWon),
                          _buildStatistic('rank', viewModel.rank),
                        ],
                      ),
                      padding: EdgeInsets.all(18),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(24, 24, 24, 12),
                      child: AppButton(text: 'Fight'),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(24, 12, 24, 24),
                      child: AppButton(text: 'History'),
                    )
                  ],
                ),
              )),
        ));
  }

  Widget _buildStatistic(String name, String value) {
    return Expanded(
        child: Column(children: [
      Text(
        value,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
      Text(
        name,
        style: TextStyle(fontSize: 14, color: Colors.grey),
      )
    ]));
  }
}
