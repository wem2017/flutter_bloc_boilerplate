import 'package:envato/blocs/bloc.dart';
import 'package:envato/configs/config.dart';
import 'package:envato/utils/utils.dart';
import 'package:envato/widgets/widget.dart';
import 'package:flutter/material.dart';

class FontSetting extends StatefulWidget {
  const FontSetting({Key? key}) : super(key: key);

  @override
  _FontSettingState createState() {
    return _FontSettingState();
  }
}

class _FontSettingState extends State<FontSetting> {
  String? currentFont = AppBloc.themeCubit.state.font;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On change Font
  void onChange() {
    AppBloc.themeCubit.onChangeTheme(font: currentFont);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: Text(
              Translate.of(context).translate('font'),
            ),
            actions: [
              AppButton(
                Translate.of(context).translate('apply'),
                onPressed: onChange,
                type: ButtonType.text,
              ),
            ],
            pinned: true,
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverPadding(
              padding: const EdgeInsets.only(top: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    Widget? trailing;
                    final item = AppTheme.fontSupport[index];
                    if (item == currentFont) {
                      trailing = Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                      );
                    }
                    return AppListTitle(
                      title: item,
                      trailing: trailing,
                      border: item != AppTheme.fontSupport.last,
                      onPressed: () {
                        setState(() {
                          currentFont = item;
                        });
                      },
                    );
                  },
                  childCount: AppTheme.fontSupport.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
