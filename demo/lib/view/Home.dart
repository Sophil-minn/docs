import 'package:flutter/material.dart' hide runApp;
import './layout.dart';

class HomePage extends LayoutPage {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;
}
