import 'package:envato/models/model.dart';

class PickerScreenModel {
  final String title;
  final PickerItemModel selected;
  final List<PickerItemModel> list;

  PickerScreenModel({
    required this.title,
    required this.selected,
    required this.list,
  });
}
