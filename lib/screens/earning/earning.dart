import 'package:envato/utils/utils.dart';
import 'package:flutter/material.dart';

class Earning extends StatefulWidget {
  Earning({Key? key}) : super(key: key);

  @override
  _EarningState createState() {
    return _EarningState();
  }
}

class _EarningState extends State<Earning> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Translate.of(context)!.translate('earning'),
        ),
      ),
      body: Container(
        child: Center(
          child: Text(
            Translate.of(context)!.translate('earning'),
          ),
        ),
      ),
    );
  }
}
