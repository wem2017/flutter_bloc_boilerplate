import 'dart:async';

import 'package:envato/blocs/bloc.dart';
import 'package:envato/configs/config.dart';
import 'package:envato/repository/repository.dart';
import 'package:envato/utils/language.dart';
import 'package:envato/utils/utils.dart';
import 'package:envato/widgets/widget.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() {
    return _SettingState();
  }
}

class _SettingState extends State<Setting> {
  final userRepository = UserRepository();

  DarkOption darkOption = AppTheme.darkThemeOption;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On Change Dark Option
  void onChangeDarkOption() {
    AppBloc.themeBloc.add(OnChangeTheme(darkOption: darkOption));
  }

  ///On navigation
  void onNavigate(String route) {
    Navigator.pushNamed(context, route);
  }

  ///Show notification received
  Future<void> showDarkModeSetting() async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        darkOption = AppTheme.darkThemeOption;
        return AlertDialog(
          title: Text(Translate.of(context)!.translate('dark_mode')),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CheckboxListTile(
                      title: Text(
                        Translate.of(context)!.translate(
                          UtilTheme.exportLangTheme(DarkOption.dynamic),
                        ),
                      ),
                      value: darkOption == DarkOption.dynamic,
                      onChanged: (value) {
                        setState(() {
                          darkOption = DarkOption.dynamic;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        Translate.of(context)!.translate(
                          UtilTheme.exportLangTheme(DarkOption.alwaysOn),
                        ),
                      ),
                      value: darkOption == DarkOption.alwaysOn,
                      onChanged: (value) {
                        setState(() {
                          darkOption = DarkOption.alwaysOn;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        Translate.of(context)!.translate(
                          UtilTheme.exportLangTheme(DarkOption.alwaysOff),
                        ),
                      ),
                      value: darkOption == DarkOption.alwaysOff,
                      onChanged: (value) {
                        setState(() {
                          darkOption = DarkOption.alwaysOff;
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          actions: <Widget>[
            AppButton(
              Translate.of(context)!.translate('close'),
              onPressed: () {
                Navigator.pop(context, false);
              },
              type: ButtonType.text,
            ),
            AppButton(
              Translate.of(context)!.translate('apply'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
    if (result == true) {
      onChangeDarkOption();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context)!.translate('setting'),
        ),
        actions: <Widget>[],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(top: 8),
          children: <Widget>[
            AppListTitle(
              icon: Icon(
                Icons.language_outlined,
                color: Theme.of(context).primaryColor,
              ),
              title: Translate.of(context)!.translate('language'),
              onPressed: () {
                onNavigate(Routes.changeLanguage);
              },
              trailing: Row(
                children: <Widget>[
                  Text(
                    UtilLanguage.getGlobalLanguageName(
                      AppLanguage.defaultLanguage.languageCode,
                    ),
                    style: Theme.of(context).textTheme.caption,
                  ),
                  RotatedBox(
                    quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
            ),
            AppListTitle(
              icon: Icon(
                Icons.color_lens_outlined,
                color: Theme.of(context).primaryColor,
              ),
              title: Translate.of(context)!.translate('theme'),
              onPressed: () {
                onNavigate(Routes.themeSetting);
              },
              trailing: Container(
                margin: EdgeInsets.only(right: 8),
                width: 16,
                height: 16,
                color: Theme.of(context).primaryColor,
              ),
            ),
            AppListTitle(
              icon: Icon(
                Icons.nights_stay_outlined,
                color: Theme.of(context).primaryColor,
              ),
              title: Translate.of(context)!.translate('dark_mode'),
              onPressed: showDarkModeSetting,
              trailing: Row(
                children: <Widget>[
                  Text(
                    Translate.of(context)!.translate(
                      UtilTheme.exportLangTheme(AppTheme.darkThemeOption),
                    ),
                    style: Theme.of(context).textTheme.caption,
                  ),
                  RotatedBox(
                    quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
            ),
            AppListTitle(
              icon: Icon(
                Icons.font_download_outlined,
                color: Theme.of(context).primaryColor,
              ),
              title: Translate.of(context)!.translate('font'),
              onPressed: () {
                onNavigate(Routes.fontSetting);
              },
              trailing: Row(
                children: <Widget>[
                  Text(
                    AppTheme.currentFont,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  RotatedBox(
                    quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
