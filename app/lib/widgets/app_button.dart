import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kenpotatakai/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final String tag;
  final VoidCallback onPressed;

  AppButton({Key key, this.text, this.icon, this.tag, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = new List();

    if (icon != null) {
      var padding = EdgeInsets.only(right: 16.0, top: 8.0, bottom: 8.0);

      var iconWidget = tag != null
          ? Padding(
              padding: padding,
              child: Hero(
                tag: tag,
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            )
          : Padding(
              padding: padding,
              child: Icon(
                icon,
                color: Colors.white,
              ),
            );

      children.add(iconWidget);
    }

    children.add(
      Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
        ),
      ),
    );

    return new InkWell(
      onTap: onPressed,
      child: Container(
        height: 56.0,
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(28.0),
          gradient: LinearGradient(
            colors: [AppColors.accentColorLight, AppColors.accentColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.4, 1.0],
          ),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children),
      ),
    );
  }
}
