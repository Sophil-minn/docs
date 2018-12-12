import 'package:flutter/material.dart' hide runApp;

class Button {
  Widget commonButton(String text, callback) {
    return Padding(
      padding: EdgeInsets.only(top: 13, bottom: 13),
      child: new Row(
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: FlatButton(
              color: Colors.blue,
              onPressed: callback,
              child: Padding(
                padding: EdgeInsets.all(13),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
