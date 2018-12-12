import 'package:flutter/material.dart' hide runApp;

class ListItem {
  Widget listItem(String imageUrl, String desc, [Function callback]) {
    return new GestureDetector(
      onTap: callback ??= () {},
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Row(
          children: <Widget>[
            new SizedBox(
              width: 18.0,
              height: 18.0,
              child: new Image.asset(
                imageUrl,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFE9F0F7), width: 1.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                  child: new Text(
                    desc,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff333333),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
