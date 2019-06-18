import 'package:flutter/widgets.dart';
import 'package:kenpotatakai/app_colors.dart';

class MainContainer extends StatelessWidget {
  final Widget child;
  final List<Color> colors;
  final List<double> stops;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  MainContainer({
    Key key,
    this.child,
    this.colors,
    this.stops,
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
  }) : super(key: key);

  factory MainContainer.primary({Key key, Widget child}) {
    return MainContainer(
        key: key, child: child, colors: [AppColors.primaryColorLight, AppColors.primaryColor], stops: [0.1, 0.9]);
  }

  factory MainContainer.accent({Key key, Widget child}) {
    return MainContainer(
        key: key, child: child, colors: [AppColors.accentColorLight, AppColors.accentColor], stops: [0.0, 1.0]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: this.colors, begin: this.begin, end: this.end, stops: this.stops)),
      child: this.child,
    );
  }
}
