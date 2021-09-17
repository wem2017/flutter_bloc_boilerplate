import 'package:flutter/material.dart';

enum TagType { status, chip, rateSmall }

class AppTag extends StatelessWidget {
  const AppTag(
    this.text, {
    Key? key,
    required this.type,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final TagType type;
  final Widget? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case TagType.rateSmall:
        return InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: Text(
              text,
              style: Theme.of(context).textTheme.caption!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        );

      case TagType.status:
        return InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Colors.white),
            ),
          ),
        );

      case TagType.chip:
        return InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.5,
                color: Theme.of(context).colorScheme.secondary,
              ),
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).focusColor,
            ),
            child: Row(
              children: <Widget>[
                icon != null
                    ? Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: icon,
                      )
                    : Container(),
                Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                )
              ],
            ),
          ),
        );

      default:
        return InkWell(
          onTap: onPressed,
          child: Container(),
        );
    }
  }
}
