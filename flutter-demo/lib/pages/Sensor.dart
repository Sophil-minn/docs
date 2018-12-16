import 'package:flutter/material.dart' hide runApp;
import 'package:aeyrium_sensor/aeyrium_sensor.dart';
import '../components/container.dart';

class SensorPage extends StatefulWidget {
  SensorPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SensorPage> with GetContainer {
  String content = "";

  Widget getBody() {
    AeyriumSensor.sensorEvents.listen((SensorEvent event) {
      //do something with the event , values expressed in radians
      setState(() {
        content = "Pitch ${event.pitch} and Roll ${event.roll}";
      });
    });

    return this.getContainer(
      Column(
        children: <Widget>[
          Text(content),
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
