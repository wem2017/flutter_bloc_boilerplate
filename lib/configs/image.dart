class Images {
  static const String Logo = "assets/images/logo.png";
  static const String Icon = "assets/images/icon.png";
  static const String Envato = "assets/images/envato.png";
  static const String Ocean = "assets/images/3docean.png";
  static const String ThemeForest = "assets/images/themeforest.png";
  static const String AudioJungle = "assets/images/audiojungle.png";
  static const String CodeCanyon = "assets/images/codecanyon.png";
  static const String Graphics = "assets/images/graphicriver.png";
  static const String Photo = "assets/images/photodune.png";
  static const String Video = "assets/images/videohive.png";

  ///Singleton factory
  static final Images _instance = Images._internal();

  factory Images() {
    return _instance;
  }

  Images._internal();
}
