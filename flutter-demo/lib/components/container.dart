import 'package:flutter/material.dart' hide runApp;

class GetContainer {
  Widget getContainer(Widget child, {bool all: true, bool right: false}) {
    EdgeInsetsGeometry padding = all == true
        ? EdgeInsets.all(20.0)
        : (right == true
            ? EdgeInsets.only(left: 20.0, top: 20, bottom: 20)
            : EdgeInsets.all(0.0));
    return new SingleChildScrollView(
      child: Container(
        child: child,
        color: Colors.white,
        margin: EdgeInsets.all(0),
        padding: padding,
        width: double.infinity,
      ),
    );
  }
}
