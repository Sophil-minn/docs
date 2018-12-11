import 'package:flutter/material.dart' hide runApp;

class GetContainer {
  Widget getContainer(Widget child) {
    return Container(
      child: child,
      color: Colors.white,
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(20.0),
      width: double.infinity,
    );
  }
}
