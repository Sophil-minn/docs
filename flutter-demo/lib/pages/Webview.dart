import 'package:flutter/material.dart' hide runApp;
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import '../components/container.dart';

class WebviewPage extends StatefulWidget {
  WebviewPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<WebviewPage> with GetContainer {
  InAppWebViewController webView;
  String url = "";
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrl: "https://flutter.io/",
      initialHeaders: {},
      initialOptions: {
        "useShouldOverrideUrlLoading": true,
        "useOnLoadResource": true,
        "clearCache": true,
        "disallowOverScroll": true,
        "domStorageEnabled": true,
        "supportZoom": false,
        "toolbarBottomTranslucent": false,
        "allowsLinkPreview": false
      },
      onWebViewCreated: (InAppWebViewController controller) {
        webView = controller;
        controller.addJavaScriptHandler("handlerNameTest", (arguments) async {
          print("handlerNameTest arguments");
          print(arguments); // it prints: [1, 5, string, {key: 5}, [4, 6, 8]]
        });
      },
      onLoadStart: (InAppWebViewController controller, String url) {
        print("started $url");
        setState(() {
          this.url = url;
        });
      },
      onProgressChanged: (InAppWebViewController controller, int progress) {
        setState(() {
          this.progress = progress / 100;
        });
      },
    );
  }
}
