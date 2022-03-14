import 'package:flutter/material.dart';

Center createDivider(textDivider) {
  return Center(
      child: Column(children: <Widget>[
    Row(children: <Widget>[
      Text(textDivider),
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: const Divider(
              color: Colors.black,
              height: 50,
              thickness: 1.5,
            )),
      ),
    ]),
  ]));
}
