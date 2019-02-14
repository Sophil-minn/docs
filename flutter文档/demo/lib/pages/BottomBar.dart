import 'package:flutter/material.dart' hide runApp;
import '../pages/Home.dart';
import '../pages/Personal.dart';

class BottomBarPage extends StatefulWidget {
  BottomBarPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BottomBarPage> {
  int _tabIndex = 0;
  List<Widget> actions;

  Widget getComponent(int i) {
    return <Widget>[
      new HomePage(
        title: "首页",
      ),
      new PersonalPage(
        title: "个人中心",
      )
    ][i];
  }

  Image getTabIcon(int pos, int ind) {
    var icon;
    switch (pos) {
      case 0:
        if (pos == ind) {
          icon = Image.asset(
            "lib/images/home@2x.png",
            width: 40,
            height: 40,
          );
        } else
          icon = Image.asset(
            "lib/images/home-h@2x.png",
            width: 40,
            height: 40,
          );
        break;
      case 1:
        if (pos == ind) {
          icon = Image.asset(
            "lib/images/personal@2x.png",
            width: 40,
            height: 40,
          );
        } else
          icon = Image.asset(
            "lib/images/personal-h@2x.png",
            width: 40,
            height: 40,
          );
        break;
    }
    return icon;
  }

  Text getTabTitle(int ind) {
    Text txt;
    switch (ind) {
      case 0:
        txt = Text(
          "首页",
          style: TextStyle(fontSize: 14),
        );
        break;
      case 1:
        txt = Text(
          "个人中心",
          style: TextStyle(fontSize: 14),
        );
        break;
    }

    return txt;
  }

  Widget getBottomBar(context, setState, int ind) {
    return new BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        new BottomNavigationBarItem(
            icon: getTabIcon(0, ind), title: getTabTitle(0)),
        new BottomNavigationBarItem(
            icon: getTabIcon(1, ind), title: getTabTitle(1)),
      ],
      //设置显示的模式
      type: BottomNavigationBarType.fixed,
      //设置当前的索引
      currentIndex: ind,
      //tabBottom的点击监听
      onTap: (index) {
        setState(() {
          _tabIndex = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getComponent(_tabIndex),
      bottomNavigationBar: getBottomBar(context, setState, _tabIndex),
    );
  }
}
