import 'dart:async';
import 'dart:io';

import 'package:envato/models/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final WebViewModel web;
  const WebViewPage({Key? key, required this.web}) : super(key: key);

  @override
  _WebViewPageState createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {
  final cookieManager = CookieManager();

  bool loaded = false;
  bool transitionCompleted = false;
  bool callbackSuccess = false;
  String? callbackUrl;
  WebViewController? controller;

  @override
  void initState() {
    super.initState();
    SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light);
    SVProgressHUD.show();
    onTransitionCompleted();
  }

  @override
  void dispose() {
    SVProgressHUD.dismiss();
    super.dispose();
  }

  void onTransitionCompleted() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      transitionCompleted = true;
    });
  }

  ///Clear Cookie
  Future<void> clearCookie() async {
    SVProgressHUD.dismiss();
    if (Platform.isIOS) {
      await controller?.clearCache();
    } else {
      await cookieManager.clearCookies();
    }
  }

  ///After load page finish
  void onPageFinished(BuildContext context, String url) async {
    SVProgressHUD.dismiss();

    ///Show WebView when Completed
    if (!loaded && mounted) {
      setState(() {
        loaded = true;
      });
    }

    ///Handle callback
    if (callbackUrl != null && !callbackSuccess) {
      if (widget.web.clearCookie) {
        await clearCookie();
      }
      callbackSuccess = true;
      Navigator.pop(context, callbackUrl);
    }
  }

  ///Build webView
  Widget buildWebView() {
    if (transitionCompleted) {
      return WebView(
        initialUrl: widget.web.url,
        javascriptMode: widget.web.javascriptMode,
        userAgent: "random",
        onWebViewCreated: (webViewController) {
          controller = webViewController;
        },
        onPageStarted: (String url) {
          SVProgressHUD.show();
        },
        onPageFinished: (String url) {
          onPageFinished(context, url);
        },
        navigationDelegate: (request) {
          final callback = widget.web.callbackUrl;
          if (request.url.startsWith(callback!)) {
            callbackUrl = request.url;
          }
          return NavigationDecision.navigate;
        },
        gestureNavigationEnabled: widget.web.gestureNavigationEnabled,
      );
    }
    return Container(color: Theme.of(context).backgroundColor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(widget.web.title),
      ),
      body: IndexedStack(
        children: [
          buildWebView(),
          Container(color: Theme.of(context).backgroundColor)
        ],
        index: loaded ? 0 : 1,
      ),
    );
  }
}
