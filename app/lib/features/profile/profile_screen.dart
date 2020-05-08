import 'package:flutter/material.dart';
import 'package:kenpotatakai/widgets/main_container.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: MainContainer.primary(
            child: Container(
                child: Center(
      child: Text('Profile!'),
    ))));
  }
}
