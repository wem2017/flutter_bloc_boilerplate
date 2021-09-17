import 'package:cached_network_image/cached_network_image.dart';
import 'package:envato/models/model.dart';
import 'package:envato/utils/utils.dart';
import 'package:envato/widgets/widget.dart';
import 'package:flutter/material.dart';

class AppUserItem extends StatelessWidget {
  final UserModel user;
  final bool processing;
  final VoidCallback? onActive;
  final VoidCallback? onDelete;

  const AppUserItem({
    Key? key,
    required this.user,
    required this.processing,
    this.onActive,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget bottom = Container();
    Widget trailing = Container();
    if (user.active) {
      trailing = Container(
        width: 20,
        height: 20,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
        ),
        child: const Icon(
          Icons.check,
          size: 16,
          color: Colors.white,
        ),
      );
    } else {
      bottom = Column(
        children: [
          const SizedBox(height: 8),
          AppButton(
            Translate.of(context).translate('set_active'),
            loading: processing,
            disabled: processing,
            onPressed: onActive!,
            type: ButtonType.outline,
          )
        ],
      );
      trailing = IconButton(
        onPressed: onDelete,
        icon: const Icon(Icons.delete_outline_outlined),
      );
    }
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 16, bottom: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl: user.image,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                placeholder: (context, url) {
                  return AppPlaceholder(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return AppPlaceholder(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(Icons.error),
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.username,
                      style: Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${Translate.of(context).translate('last_used')} ${UtilTimeZone.viewTime(user.lastUsed)}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              trailing,
            ],
          ),
          bottom,
        ],
      ),
    );
  }
}
