import 'package:envato/blocs/bloc.dart';
import 'package:envato/screens/screen.dart';
import 'package:envato/utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() {
    return _BottomNavigationState();
  }
}

class _BottomNavigationState extends State<BottomNavigation>
    with WidgetsBindingObserver {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((message) {
      UtilLogger.log("onMessage", message);
    });
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  ///Handle AppState
  @override
  void didChangeAppLifecycleState(state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      AppBloc.appStateBloc.add(OnResume());
    }
    if (state == AppLifecycleState.paused) {
      AppBloc.appStateBloc.add(OnBackground());
    }
  }

  ///On change tab bottom menu
  Future<void> _onItemTapped(index) async {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: <Widget>[DashBoard(), Profile()],
        index: selectedIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: Translate.of(context)!.translate('dashboard'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: Translate.of(context)!.translate('account'),
          ),
        ],
        selectedFontSize: 12,
        unselectedFontSize: 10,
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
