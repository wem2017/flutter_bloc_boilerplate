import 'package:envato/blocs/bloc.dart';
import 'package:envato/configs/config.dart';
import 'package:envato/utils/utils.dart';
import 'package:envato/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FontSetting extends StatefulWidget {
  FontSetting({Key? key}) : super(key: key);

  @override
  _FontSettingState createState() {
    return _FontSettingState();
  }
}

class _FontSettingState extends State<FontSetting> {
  String currentFont = AppTheme.currentFont;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On change Font
  Future<void> onChange() async {
    AppBloc.themeBloc.add(OnChangeTheme(font: currentFont));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context)!.translate('font'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(left: 16, top: 8),
                itemBuilder: (context, index) {
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
                    onPressed: () {
                      setState(() {
                        currentFont = item;
                      });
                    },
                  );
                },
                itemCount: AppTheme.fontSupport.length,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
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
