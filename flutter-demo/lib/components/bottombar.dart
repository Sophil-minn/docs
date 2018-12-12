import 'package:flutter/material.dart' hide runApp;

class BottomBar {
  int _tabIndex = 0;
  List<Widget> actions;

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
        if (index == 0) {
          Navigator.of(context).pushReplacementNamed("/home");
        } else if (index == 1) {
          Navigator.of(context).pushReplacementNamed("/personal");
        }
        setState(() {
          _tabIndex = index;
        });
      },
    );
  }

  List<Widget> getActions() {
    return <Widget>[
      new IconButton(
        icon: const Icon(Icons.menu),
        tooltip: '更多',
        onPressed: () {
          print('more...');
        },
      ),
    ];
  }
}
