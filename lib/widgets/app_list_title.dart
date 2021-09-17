import 'package:flutter/material.dart';

class AppListTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onPressed;
  final bool border;

  const AppListTitle({
    Key? key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onPressed,
    this.border = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Border? borderWidget;
    Widget subTitle = Container();
    Widget leadingWidget = const SizedBox(width: 16);
    if (leading != null) {
      leadingWidget = Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: leading,
      );
    }
    if (subtitle != null) {
      subTitle = Padding(
        padding: const EdgeInsets.only(top: 8),
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
      child: Container(
        color: Theme.of(context).cardColor,
        child: Row(
          children: [
            leadingWidget,
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
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            subTitle
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: trailing ?? Container(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
