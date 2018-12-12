import 'package:flutter/material.dart' hide runApp;
import '../components/bottombar.dart';
import '../components/container.dart';
import '../components/list_item.dart';

class PersonalPage extends StatefulWidget {
  PersonalPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PersonalPage>
    with BottomBar, GetContainer, ListItem {
  Widget getBody() {
    return this.getContainer(
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                top: 16,
                bottom: 16,
              ),
              child: Row(
                children: <Widget>[
                  new ClipOval(
                    child: new SizedBox(
                      width: 54.0,
                      height: 54.0,
                      child: new Image.asset(
                        "lib/images/user@2x.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  new GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/registlogin');
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: new Text(
                        "点击登录",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff333333),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(children: <Widget>[
                listItem("lib/images/wdjk@2x.png", "我的借款", () {
                  Navigator.of(context).pushNamed("/loanlist");
                }),
                listItem("lib/images/wdyhk@2x.png", "我的银行卡", () {
                  // Navigator.of(context).pushNamed("/certify");
                }),
                listItem("lib/images/wdzl@2x.png", "我的资料", () {
                  Navigator.of(context).pushNamed("/certify");
                }),
              ]),
            ),
            Container(
              color: Color(0xFFF5F6F8),
              padding: EdgeInsets.all(5),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(children: <Widget>[
                listItem("lib/images/helper@2x.png", "帮助中心", () {
                  // Navigator.of(context).pushNamed("/certify");
                }),
                listItem("lib/images/more@2x.png", "更多", () {
                  // Navigator.of(context).pushNamed("/certify");
                }),
              ]),
            ),
          ],
        ),
        right: false,
        all: false);
  }

  List<Widget> getActions() {
    return <Widget>[
      new IconButton(
        icon: const Icon(Icons.message),
        tooltip: '更多',
        onPressed: () {
          print('more...');
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: getActions(),
      ),
      body: getBody(),
      bottomNavigationBar: getBottomBar(context, setState, 1),
    );
  }
}
