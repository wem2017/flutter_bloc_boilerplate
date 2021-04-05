import 'package:envato/blocs/bloc.dart';
import 'package:envato/configs/config.dart';
import 'package:envato/models/model.dart';
import 'package:envato/utils/utils.dart';
import 'package:envato/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignIn> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On login
  Future<void> onLogin() async {
    AppBloc.loginBloc.add(OnLogin(username: 'code', password: 'result'));
  }

  ///On Privacy
  void onPrivacy() {
    Navigator.pushNamed(
      context,
      Routes.webView,
      arguments: WebViewModel(
        title: Translate.of(context)!.translate('privacy'),
        url: "https://saleboltapp.com/privacy-policy.html",
      ),
    );
  }

  ///On show message fail
  Future<void> showMessage(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            Translate.of(context)!.translate('sign_in'),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            AppButton(
              Translate.of(context)!.translate('close'),
              onPressed: () {
                Navigator.pop(context, false);
              },
              type: ButtonType.text,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, loginListen) {
          if (loginListen is LoginFail) {
            showMessage(loginListen.message);
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, login) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(Images.Icon),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Text(
                                  'SaleBolt',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(24),
                                child: Text(
                                  Translate.of(context)!
                                      .translate('app_slogan'),
                                  style: Theme.of(context).textTheme.bodyText2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              AppButton(
                                Translate.of(context)!.translate(
                                  'login_with_envato',
                                ),
                                icon: Image.asset(
                                  Images.Envato,
                                  width: 24,
                                  height: 24,
                                ),
                                onPressed: onLogin,
                                type: ButtonType.outline,
                                loading: login is LoginLoading,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        Translate.of(context)!.translate('app_noted'),
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: AppButton(
                        Translate.of(context)!.translate('privacy'),
                        onPressed: onPrivacy,
                        type: ButtonType.text,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
