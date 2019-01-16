import 'package:flutter/material.dart' hide runApp;
import './pages/Home.dart';
import './pages/Personal.dart';
import './pages/RegistLogin.dart';
import './pages/Login.dart';
import './pages/Certify.dart';
import './pages/LoanList.dart';
import './pages/BottomBar.dart';
import './pages/Webview.dart';
import './pages/Music.dart';
import './pages/Video.dart';
import './pages/Sensor.dart';
import './pages/Record.dart';
import './pages/PickImage.dart';
import './pages/CustomView.dart';
import './pages/Dio.dart';
import './pages/Test.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: BottomBarPage(title: '顺风贷'),
      routes: {
        '/home': (BuildContext context) => HomePage(title: "顺风贷"),
        '/personal': (BuildContext context) => PersonalPage(title: "个人中心"),
        '/registlogin': (BuildContext context) =>
            RegistLoginPage(title: "登录注册"),
        '/login': (BuildContext context) => LoginPage(title: "登录"),
        '/regist': (BuildContext context) => LoginPage(title: "注册"),
        '/certify': (BuildContext context) => CertifyPage(title: "认证中心"),
        '/loanlist': (BuildContext context) => LoanListPage(title: "我的借款"),
        '/test': (BuildContext context) => TestPage(title: "测试Demo"),
        '/music': (BuildContext context) => MusicPage(title: "Music"),
        '/video': (BuildContext context) => VideoPage(title: "Vedio"),
        '/sensor': (BuildContext context) => SensorPage(title: "Sensor"),
        '/record': (BuildContext context) => RecordPage(title: "record"),
        '/customview': (BuildContext context) =>
            CustomViewPage(title: "customview"),
        '/pickimage': (BuildContext context) =>
            PickImagePage(title: "pickimage"),
        '/webview': (BuildContext context) => WebviewPage(title: "webview"),
        '/dio': (BuildContext context) => DioPage(title: "DIO"),
      },
    );
  }
}
