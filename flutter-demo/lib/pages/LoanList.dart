import 'package:flutter/material.dart' hide runApp;
import '../components/container.dart';
import '../components/button.dart';
import '../components/loanlist-item.dart';

class LoanListPage extends StatefulWidget {
  LoanListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoanListPage>
    with GetContainer, Button, LoanListItem {
  Widget getBody() {
    return this.getContainer(
      Column(
        children: <Widget>[
          loanListItem(
            title: "借款2500元",
            subTitle: "2017-12-06",
            statusText: "展期待还",
            callback: () {
              print("...");
            },
          ),
          loanListItem(
            title: "借款2500元",
            subTitle: "2017-12-05",
            statusText: "已结清",
            statusColor: Color(0xFF999999),
            callback: () {
              print("...");
            },
          ),
          loanListItem(
            title: "借款2500元",
            subTitle: "2017-12-04",
            statusText: "展期待还",
            callback: () {
              print("...");
            },
          ),
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
      ),
      body: getBody(),
    );
  }
}
