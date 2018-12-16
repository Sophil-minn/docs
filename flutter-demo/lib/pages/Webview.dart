import 'package:flutter/material.dart' hide runApp;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../components/container.dart';

class WebviewPage extends StatefulWidget {
  WebviewPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<WebviewPage> with GetContainer {
  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: "http://html5test.com/",
      appBar: new AppBar(
        title: Text(widget.title),
      ),
      withZoom: true,
      withLocalStorage: true,
      allowFileURLs: true,
      withLocalUrl: true,
      appCacheEnabled: true,
      enableAppScheme: true,
      withJavascript: true,
      // hidden: true,
      // initialChild: Container(
      //   color: Colors.redAccent,
      //   child: const Center(
      //     child: Text('Waiting.....'),
      //   ),
      // ),
    );
  }
}
