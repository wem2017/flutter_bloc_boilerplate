import 'dart:async';

import 'package:envato/blocs/bloc.dart';
import 'package:envato/screens/screen.dart';
import 'package:envato/utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class AppContainer extends StatefulWidget {
  const AppContainer({Key? key}) : super(key: key);

  @override
  _AppContainerState createState() {
    return _AppContainerState();
  }
}

class _AppContainerState extends State<AppContainer>
    with WidgetsBindingObserver {
  late StreamSubscription signSubscription;
  late StreamSubscription<RemoteMessage> onMessage;
  late StreamSubscription<RemoteMessage> onMessageOpenedApp;

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    ///Remote notification listen
    onMessage = FirebaseMessaging.onMessage.listen((message) {});

    ///Remote notification listen
    onMessageOpenedApp =
        FirebaseMessaging.onMessageOpenedApp.listen((message) {});

    ///AppState add observer
    WidgetsBinding.instance!.addObserver(this);

    ///SignOut event
    signSubscription = AppBloc.signCubit.stream.listen((state) {
      if (state == SignState.signOut) {
        Navigator.popUntil(
          context,
          ModalRoute.withName(Navigator.defaultRouteName),
        );
      }
    });
  }

  @override
  void dispose() {
    onMessage.cancel();
    onMessageOpenedApp.cancel();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  ///Handle AppState
  @override
  void didChangeAppLifecycleState(state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {}
  }

  ///On change tab bottom menu
  void onItemTapped(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: const <Widget>[DashBoard(), Account()],
        index: selectedIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard_outlined),
            label: Translate.of(context).translate('dashboard'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle_outlined),
            label: Translate.of(context).translate('account'),
          ),
        ],
        selectedFontSize: 12,
        unselectedFontSize: 10,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
