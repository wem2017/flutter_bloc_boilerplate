import 'package:flutter/material.dart';

class AppListTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget? icon;
  final VoidCallback? onPressed;
  final bool border;

  AppListTitle({
    Key? key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.icon,
    this.onPressed,
    this.border = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Border? borderWidget;
    Widget subTitle = Container();
    Widget iconWidget = Container();
    if (icon != null) {
      iconWidget = Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: icon,
      );
    }
    if (subtitle != null) {
      subTitle = Padding(
        padding: EdgeInsets.only(top: 8),
        child: Text(
          subtitle!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Theme.of(context).primaryColor),
        ),
      );
    }
    if (border) {
      borderWidget = Border(
        bottom: BorderSide(
          width: 1,
          color: Theme.of(context).dividerColor,
        ),
      );
    }
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          iconWidget,
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: borderWidget,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          subTitle
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: trailing ?? Container(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
