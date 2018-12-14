import 'package:flutter/material.dart' hide runApp;
import '../components/container.dart';
import '../components/button.dart';

class TestPage extends StatefulWidget {
  TestPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TestPage> with GetContainer, Button {
  Widget getBody() {
    return this.getContainer(
      Column(
        children: <Widget>[
          commonButton("webview", () {
            Navigator.of(context).pushNamed('/webview');
          }),
          commonButton("tt", () {
            Navigator.of(context).pushNamed('/webview');
          }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: getBody(),
    );
  }
}
