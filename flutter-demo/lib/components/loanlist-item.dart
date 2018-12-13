import 'package:flutter/material.dart' hide runApp;

class LoanListItem {
  Widget loanListItem({
    String title,
    String subTitle,
    String statusText,
    Color statusColor,
    Function callback,
  }) {
    return new GestureDetector(
      onTap: callback ??= () {},
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFE9F0F7), width: 1.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 7,
            bottom: 10,
            right: 16,
          ),
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title ??= "",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF333333),
                    ),
                  ),
                  Text(
                    subTitle ??= "",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 1,
                child: Row(
                  // mainAxisSize: MainAxisSize.max,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      statusText ??= "",
                      style: TextStyle(
                        fontSize: 13,
                        color: statusColor ??= Color(0xFFFFB000),
                      ),
                    ),
                    Image.asset(
                      "lib/images/arrow@2x.png",
                      width: 15,
                      height: 15,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
