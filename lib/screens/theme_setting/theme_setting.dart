import 'package:envato/blocs/bloc.dart';
import 'package:envato/configs/config.dart';
import 'package:envato/models/model.dart';
import 'package:envato/utils/utils.dart';
import 'package:envato/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSetting extends StatefulWidget {
  ThemeSetting({Key? key}) : super(key: key);

  @override
  _ThemeSettingState createState() {
    return _ThemeSettingState();
  }
}

class _ThemeSettingState extends State<ThemeSetting> {
  ThemeModel currentTheme = AppTheme.currentTheme;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On Change Theme
  void onChange() {
    AppBloc.themeBloc.add(OnChangeTheme(theme: currentTheme));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context)!.translate('theme'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                itemBuilder: (context, index) {
                  Widget selected = Container();
                  final item = AppTheme.themeSupport[index];
                  if (item.name == currentTheme.name) {
                    selected = Icon(
                      Icons.check,
                      color: Theme.of(context).primaryColor,
                    );
                  }
                  return InkWell(
                    onTap: () {
                      setState(() {
                        currentTheme = item;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 24,
                                  height: 24,
                                  color: item.color,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                ),
                                Text(
                                  Translate.of(context)!.translate(item.name),
                                  style: Theme.of(context).textTheme.subtitle2,
                                )
                              ],
                            ),
                            selected,
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: AppTheme.themeSupport.length,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 15,
                bottom: 15,
              ),
              child: BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, theme) {
                  return AppButton(
                    Translate.of(context)!.translate('apply'),
                    onPressed: onChange,
                    loading: theme is ThemeUpdating,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
