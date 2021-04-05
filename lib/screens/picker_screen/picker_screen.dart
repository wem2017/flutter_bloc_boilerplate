import 'package:envato/models/model.dart';
import 'package:envato/widgets/widget.dart';
import 'package:flutter/material.dart';

class PickerScreen extends StatefulWidget {
  final PickerScreenModel picker;
  PickerScreen({Key? key, required this.picker}) : super(key: key);

  @override
  _PickerScreenState createState() {
    return _PickerScreenState();
  }
}

class _PickerScreenState extends State<PickerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On change language
  Future<void> onChange(PickerItemModel item) async {
    Navigator.pop(context, item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.picker.title,
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.only(left: 16, top: 8),
          itemBuilder: (context, index) {
            final item = widget.picker.list[index];
            Widget? checked;
            if (item.value == widget.picker.selected.value) {
              checked = Icon(
                Icons.check,
                color: Theme.of(context).primaryColor,
              );
            }
            return AppListTitle(
              title: item.label,
              trailing: checked,
              onPressed: () {
                onChange(item);
              },
            );
          },
          itemCount: widget.picker.list.length,
        ),
      ),
    );
  }
}
