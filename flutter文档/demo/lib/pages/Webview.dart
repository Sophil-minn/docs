import 'package:flutter/material.dart' hide runApp;
import '../components/container.dart';
import './WebviewImp.dart';

class WebviewPage extends StatefulWidget {
  WebviewPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<WebviewPage> with GetContainer {
  WebviewImp inAppBrowser = new WebviewImp();

  @override
  void initState() {
    super.initState();
    print('handlerNameTest ready');
    // listen for post messages coming from the JavaScript side
    int indexTest = this
        .inAppBrowser
        .webViewController
        .addJavaScriptHandler("handlerNameTest", (arguments) async {
      print("handlerNameTest arguments");
      print(arguments); // it prints: [1, 5, string, {key: 5}, [4, 6, 8]]
    });
  }

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      onPressed: () async {
        await this.inAppBrowser.open(url: "http://baidu.com/", options: {
          "useShouldOverrideUrlLoading": true,
          "useOnLoadResource": true,
          "clearCache": true,
        });
      },
      child: Text("Open InAppBrowser"),
    );
  }
}
