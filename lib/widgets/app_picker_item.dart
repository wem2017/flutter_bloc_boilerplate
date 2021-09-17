import 'package:flutter/material.dart';

class AppPickerItem extends StatelessWidget {
  final String title;
  final String? value;
  final Widget? leading;
  final bool loading;
  final VoidCallback onPressed;

  const AppPickerItem({
    Key? key,
    required this.title,
    this.value,
    this.leading,
    this.loading = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).hintColor;
    String titlePicker = title;
    if (value != null && value!.isNotEmpty) {
      color = Theme.of(context).textTheme.subtitle1!.color!;
      titlePicker = value!;
    }

    Widget trailingWidget = Icon(
      Icons.arrow_drop_down,
      color: color,
    );
    if (loading) {
      trailingWidget = const Padding(
        padding: EdgeInsets.all(4),
        child: SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      );
    }

    Widget leadingWidget = const SizedBox(width: 16);
    if (leading != null) {
      leadingWidget = Row(
        children: [
          const SizedBox(width: 8),
          leading!,
          const SizedBox(width: 8),
        ],
      );
    }

    return InkWell(
      onTap: loading ? null : onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).dividerColor.withOpacity(.07),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            leadingWidget,
            Expanded(
              child: Text(
                titlePicker,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: color),
              ),
            ),
            trailingWidget,
            const SizedBox(width: 8)
          ],
        ),
      ),
    );
  }
}
