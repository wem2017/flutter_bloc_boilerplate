import 'package:envato/blocs/bloc.dart';
import 'package:envato/configs/config.dart';
import 'package:envato/utils/utils.dart';
import 'package:envato/widgets/widget.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On logout
  Future<void> onLogout() async {
    AppBloc.loginBloc.add(OnLogout());
  }

  ///On navigation
  void onNavigate(String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Translate.of(context)!.translate('profile'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            AppListTitle(
              title: Translate.of(context)!.translate('setting'),
              icon: Icon(
                Icons.settings_outlined,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                onNavigate(Routes.setting);
              },
              trailing: Row(
                children: <Widget>[
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
              title: Translate.of(context)!.translate('sign_out'),
              icon: Icon(
                Icons.logout,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: onLogout,
              trailing: Row(
                children: <Widget>[
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
