class Images {
  static const String logo = "assets/images/logo.png";
  static const String icon = "assets/images/icon.png";
  static const String envato = "assets/images/envato.png";
  static const String ocean = "assets/images/3docean.png";
  static const String themeForest = "assets/images/themeforest.png";
  static const String audioJungle = "assets/images/audiojungle.png";
  static const String codeCanyon = "assets/images/codecanyon.png";
  static const String graphics = "assets/images/graphicriver.png";
  static const String photo = "assets/images/photodune.png";
  static const String video = "assets/images/videohive.png";
  static const String coffee = "assets/images/coffee.jpg";
  static const String lunch = "assets/images/lunch.jpg";
  static const String support = "assets/images/support.jpg";
  static const String emptyFlare = "assets/animation/Empty.flr";
  static const String defaultThumb =
      "https://envato.com/static/media/logo_192.0801aa8d.png";

  ///Singleton factory
  static final Images _instance = Images._internal();

  factory Images() {
    return _instance;
  }

  Images._internal();
}
