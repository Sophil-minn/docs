import 'package:flutter/material.dart' hide runApp;
import '../components/container.dart';
import '../components/button.dart';
import '../utils/dio.dart';

class DioPage extends StatefulWidget {
  DioPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DioPage> with GetContainer, Button {
  Widget getBody() {
    return this.getContainer(
      Column(
        children: <Widget>[
          commonButton("ss", () {
            // Axios.instance.post('/interface/api/u_m_getUserInfo', data: {
            //   "paramMap": {
            //     "appId": "sfd",
            //     "mobilePhone": "15432311232",
            //     "bizId": "sfd"
            //   }
            // }).then((res) {
            //   print(res);
            // });
            var s = {
              "name": {"son": "hzj"}
            };
            // var b = new Map.from({});
            print(s.toString());
          }),
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
      ),
      body: getBody(),
    );
  }
}
