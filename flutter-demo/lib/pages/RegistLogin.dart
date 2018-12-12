import 'package:flutter/material.dart' hide runApp;
import '../components/bottombar.dart';
import '../components/container.dart';
import '../components/button.dart';
import '../utils/index.dart';

class RegistLoginPage extends StatefulWidget {
  RegistLoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<RegistLoginPage>
    with BottomBar, GetContainer, Button {
  //手机号的控制器
  TextEditingController phoneController = TextEditingController();

  Widget getBody() {
    return this.getContainer(
      Column(
        children: <Widget>[
          Row(children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "顺风贷",
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFF131D31),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]),
          Row(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "输入登录或注册的手机号",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF5C6579),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFE9F0F7), width: 1.0),
              ),
            ),
            padding: EdgeInsets.only(top: 50),
            child: Row(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  // top: -10,
                  right: 15,
                ),
                child: Text(
                  "手机号",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF333333),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 8),
                constraints: new BoxConstraints.expand(
                  width: 185.0,
                  height: 50.0,
                ),
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                    // labelText: '请输入你的用户名)',
                    // helperText: '请输入注册的手机号',
                  ),
                  autofocus: false,
                ),
              ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: commonButton("登录/注册", () {
              // dio.post('/interface/api/u_m_getUserInfo', data: {
              //   "paramMap": {
              //     "appId": "sfd",
              //     "mobilePhone": "15432311232",
              //     "bizId": "sfd"
              //   }
              // }).then((res) {
              //   print(res);
              // });

              Navigator.of(context).pushNamed('/login');
            }),
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
        // actions: getActions(),
      ),
      body: getBody(),
      // bottomNavigationBar: getBottomBar(context, setState, 0),
    );
  }
}
