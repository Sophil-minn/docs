import 'package:flutter/material.dart' hide runApp;
import '../components/bottombar.dart';
import '../components/container.dart';
import '../components/button.dart';

class PersonalPage extends StatefulWidget {
  PersonalPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PersonalPage>
    with BottomBar, GetContainer, Button {
  Widget getBody() {
    return this.getContainer(
      Column(
        children: <Widget>[
          new Text(
            "最高可借(元)",
            style: TextStyle(
              color: const Color(0xFF9F9F9F),
              fontSize: 13.0,
            ),
          ),
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
      bottomNavigationBar: getBottomBar(context, setState, 1),
    );
  }
}
