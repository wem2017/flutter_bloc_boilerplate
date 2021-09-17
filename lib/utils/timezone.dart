import 'package:envato/blocs/bloc.dart';
import 'package:envato/configs/config.dart';
import 'package:intl/intl.dart';

class UtilTimeZone {
  /// return time of user or server
  static DateTime now() {
    final local = DateTime.now();
    final utc = DateTime.now().toUtc();
    DateTime convert = utc.add(local.timeZoneOffset);
    if (Application.localTimeZone == false) {
      convert = utc.add(const Duration(hours: 10));
    }
    return convert;
  }

  /// return DateTime of Server
  /// datetime is utc
  static DateTime utcToServerZone(DateTime datetime, {Duration? duration}) {
    DateTime convert = datetime.add(duration ?? const Duration(hours: 10));
    return convert;
  }

  /// String Time of server
  /// datetime is utc
  static String utcToServerTime(DateTime datetime, {String? format}) {
    DateTime convert = datetime.add(const Duration(hours: 10));
    return DateFormat(format ?? 'yyyy-MM-dd').format(convert);
  }

  /// String Time local time or server
  /// datetime is utc
  static String viewTime(
    DateTime datetime, {
    String? format,
    String? language,
  }) {
    final local = DateTime.now();
    DateTime convert = datetime.add(local.timeZoneOffset);
    if (Application.localTimeZone == false) {
      convert = datetime.add(const Duration(hours: 10));
    }
    return DateFormat(
      format ?? Application.dateFormat,
      language ?? AppBloc.languageCubit.state.languageCode,
    ).format(convert);
  }

  /// Return DateTime timezone user or server
  /// datetime is utc
  static DateTime utcToZone(DateTime datetime) {
    final local = DateTime.now();
    DateTime convert = datetime.add(local.timeZoneOffset);
    if (Application.localTimeZone == false) {
      convert = datetime.add(const Duration(hours: 10));
    }
    return convert;
  }

  /// Convert a DateTime to UTC Time
  /// datetime is user timezone or server time

  static DateTime zoneToUtc(DateTime datetime) {
    final local = DateTime.now();
    DateTime convert = datetime.subtract(local.timeZoneOffset);
    if (Application.localTimeZone == false) {
      convert = datetime.subtract(const Duration(hours: 10));
    }
    return DateTime.utc(
      convert.year,
      convert.month,
      convert.day,
      convert.hour,
      convert.minute,
      convert.second,
      convert.millisecond,
      convert.microsecond,
    );
  }

  ///Singleton factory
  static final _instance = UtilTimeZone._internal();

  factory UtilTimeZone() {
    return _instance;
  }

  UtilTimeZone._internal();
}
