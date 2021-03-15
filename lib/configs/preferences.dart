class Preferences {
  static String cleanUp = 'cleanUp';
  static String localTimeZone = 'localTimeZone';
  static String language = 'language';
  static String theme = 'theme';
  static String darkOption = 'darkOption';
  static String font = 'font';

  ///Singleton factory
  static final Preferences _instance = Preferences._internal();

  factory Preferences() {
    return _instance;
  }

  Preferences._internal();
}
