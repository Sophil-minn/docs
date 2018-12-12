import 'package:flutter/material.dart' hide runApp;
import '../components/bottombar.dart';
import '../components/container.dart';
import '../components/button.dart';

class CertifyPage extends StatefulWidget {
  CertifyPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CertifyPage>
    with BottomBar, GetContainer, Button {
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
      // bottomNavigationBar: getBottomBar(context, setState, 0),
    );
  }
}
