import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kenpotatakai/widgets/main_container.dart';

class FullScreenLoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MainContainer.primary(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ));
  }
}
