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
          commonButton("Music", () {
            Navigator.of(context).pushNamed('/music');
          }),
          commonButton("Video", () {
            Navigator.of(context).pushNamed('/video');
          }),
          commonButton("Sensor", () {
            Navigator.of(context).pushNamed('/sensor');
          }),
          commonButton("Record", () {
            Navigator.of(context).pushNamed('/record');
          }),
          commonButton("PickImage", () {
            Navigator.of(context).pushNamed('/pickimage');
          }),
          commonButton("CustomView", () {
            Navigator.of(context).pushNamed('/customview');
          }),
          commonButton("DIO", () {
            Navigator.of(context).pushNamed('/dio');
          }),
          commonButton("xxx", () {
            Navigator.of(context).pushNamed('/pickimage');
          }),
          commonButton("xxx", () {
            Navigator.of(context).pushNamed('/customview');
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
