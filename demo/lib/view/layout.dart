import 'package:flutter/material.dart' hide runApp;

class LayoutPage extends StatefulWidget {
  LayoutPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LayoutPage> {
  int _tabIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: const Icon(Icons.more_horiz),
            tooltip: '更多',
            onPressed: () {
              print('more...');
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[],
        ),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              icon: getTabIcon(0), title: getTabTitle(0)),
          new BottomNavigationBarItem(
              icon: getTabIcon(1), title: getTabTitle(1)),
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
      ),
    );
  }
}