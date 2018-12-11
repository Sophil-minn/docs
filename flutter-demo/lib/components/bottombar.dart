import 'package:flutter/material.dart' hide runApp;

class BottomBar {
  int _tabIndex = 0;
  List<Widget> actions;

  Image getTabIcon(int ind) {
    var icon;
    switch (ind) {
      case 0:
        if (_tabIndex == ind) {
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
        if (_tabIndex == ind) {
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

  Widget getBottomBar(context, setState) {
    return new BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        new BottomNavigationBarItem(icon: getTabIcon(0), title: getTabTitle(0)),
        new BottomNavigationBarItem(icon: getTabIcon(1), title: getTabTitle(1)),
      ],
      //设置显示的模式
      type: BottomNavigationBarType.fixed,
      //设置当前的索引
      currentIndex: _tabIndex,
      //tabBottom的点击监听
      onTap: (index) {
        if (index == 0 && _tabIndex != index) {
          Navigator.of(context).pushNamed("/home");
        } else if (index == 1 && _tabIndex != index) {
          Navigator.of(context).pushNamed("/personal");
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
        icon: const Icon(Icons.more_horiz),
        tooltip: '更多',
        onPressed: () {
          print('more...');
        },
      ),
    ];
  }
}
