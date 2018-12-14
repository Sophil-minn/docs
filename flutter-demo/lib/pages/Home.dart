import 'package:flutter/material.dart' hide runApp;
import '../components/container.dart';
import '../components/button.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> with GetContainer, Button {
  String getImage(int i) {
    return <String>["lib/images/banner-01.png", "lib/images/banner-02.png"][i];
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
          new Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset(
                "lib/images/index_maxnum_bg.png",
                fit: BoxFit.fill,
                width: double.infinity,
              ),
              new Center(
                child: new Padding(
                  padding: new EdgeInsets.all(20.0),
                  child: new Text(
                    "5000",
                    style: TextStyle(
                      color: const Color(0xFF333333),
                      fontSize: 56.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Center(
            child: new Row(
              mainAxisSize: MainAxisSize.min, // !!!!
              children: <Widget>[
                new Text(
                  "高通过",
                  style: TextStyle(),
                ),
                new Text(
                  "丨",
                  style: TextStyle(),
                ),
                new Text("秒下款"),
                new Text("丨"),
                new Text("可展期"),
              ],
            ),
          ),
          new ConstrainedBox(
            child: new Swiper(
              outer: false,
              itemBuilder: (c, i) {
                return new Image.asset(getImage(i));
              },
              pagination: new SwiperPagination(margin: new EdgeInsets.all(5.0)),
              itemCount: 2,
              autoplayDelay: 3000,
            ),
            constraints: new BoxConstraints.loose(
              new Size(500, 170.0),
            ),
          ),
          commonButton('获取额度', () {
            print('f');
            Navigator.of(context).pushNamed("/certify");
          }),
          commonButton('其它Flutter功能测试', () {
            Navigator.of(context).pushNamed("/test");
          })
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
        actions: getActions(),
      ),
      body: getBody(),
    );
  }
}
