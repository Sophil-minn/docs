import 'package:flutter/material.dart' hide runApp;
import '../components/container.dart';

class RecordPage extends StatefulWidget {
  RecordPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<RecordPage> with GetContainer {
  Widget getBody() {
    return this.getContainer(
      Column(
        children: <Widget>[],
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
