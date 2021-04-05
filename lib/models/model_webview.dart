import 'package:webview_flutter/webview_flutter.dart';

class WebViewModel {
  final String url;
  final String? callbackUrl;
  final String title;
  final JavascriptMode javascriptMode;
  final bool gestureNavigationEnabled;
  final bool clearCookie;

  WebViewModel({
    required this.url,
    this.callbackUrl,
    this.title = 'title',
    this.javascriptMode = JavascriptMode.unrestricted,
    this.gestureNavigationEnabled = true,
    this.clearCookie = false,
  });
}
