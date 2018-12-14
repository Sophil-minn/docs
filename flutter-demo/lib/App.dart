import 'package:flutter/material.dart' hide runApp;
import './pages/Home.dart';
import './pages/Personal.dart';
import './pages/RegistLogin.dart';
import './pages/Login.dart';
import './pages/Certify.dart';
import './pages/LoanList.dart';
import './pages/BottomBar.dart';
import './pages/Test.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

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
        '/webview': (BuildContext context) => new WebviewScaffold(
              url: "https://baidu.com/",
              appBar: new AppBar(
                title: new Text("WebView"),
              ),
              withZoom: true,
              withLocalStorage: true,
              allowFileURLs: true,
              withLocalUrl: true,
              appCacheEnabled: true,
              enableAppScheme: true,
              withJavascript: true,
              // hidden: true,
              // initialChild: Container(
              //   color: Colors.redAccent,
              //   child: const Center(
              //     child: Text('Waiting.....'),
              //   ),
              // ),
            ),
      },
    );
  }
}
