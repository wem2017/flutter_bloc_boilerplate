import 'package:envato/models/model.dart';

class PickerScreenModel {
  final String title;
  final PickerItemModel selected;
  final List<PickerItemModel> list;

  PickerScreenModel({
    this.title,
    this.selected,
    this.list,
  });
}
