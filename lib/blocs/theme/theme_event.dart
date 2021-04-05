import 'package:envato/configs/config.dart';
import 'package:envato/models/model.dart';

abstract class ThemeEvent {}

class OnChangeTheme extends ThemeEvent {
  final ThemeModel? theme;
  final String? font;
  final DarkOption? darkOption;

  OnChangeTheme({
    this.theme,
    this.font,
    this.darkOption,
  });
}
