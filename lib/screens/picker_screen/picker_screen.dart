import 'package:envato/models/model.dart';
import 'package:envato/widgets/widget.dart';
import 'package:flutter/material.dart';

class PickerScreen extends StatefulWidget {
  final PickerScreenModel picker;
  const PickerScreen({Key? key, required this.picker}) : super(key: key);

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

  ///On change
  void onChange(PickerItemModel item) {
    Navigator.pop(context, item);
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
              widget.picker.title,
            ),
            pinned: true,
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverPadding(
              padding: const EdgeInsets.only(top: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
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
                      border: item != widget.picker.list.last,
                      onPressed: () {
                        onChange(item);
                      },
                    );
                  },
                  childCount: widget.picker.list.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
