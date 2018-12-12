import 'package:flutter/material.dart' hide runApp;
import '../components/bottombar.dart';
import '../components/container.dart';
import '../components/button.dart';

class LoanListPage extends StatefulWidget {
  LoanListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoanListPage>
    with BottomBar, GetContainer, Button {
  Widget getBody() {
    return this.getContainer(
      Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFE9F0F7), width: 1.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(0),
              child: Row(
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "借款2500元",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF333333),
                          ),
                        ),
                        Text(
                          "2017-12-06",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF999999),
                          ),
                        ),
                      ]),
                  Text(
                    "展期待还",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFFFFB000),
                    ),
                  ),
                  Image.asset("lib/images/arrow@2x.png")
                ],
              ),
            ),
          )
        ],
      ),
      right: true,
      all: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        // actions: getActions(),
      ),
      body: getBody(),
      // bottomNavigationBar: getBottomBar(context, setState, 0),
    );
  }
}
