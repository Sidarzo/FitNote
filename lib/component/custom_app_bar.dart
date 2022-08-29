import 'package:flutter/material.dart';

class CustomBottomAppBar {
  static BottomAppBar buildAppBar(context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: const Color.fromARGB(255, 32, 32, 32),
      child: IconTheme(
        data: const IconThemeData(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          IconButton(              
              splashRadius: 0.1,
              onPressed: () async {
              Navigator.pushNamed(context, '/programform');
            }, icon: const Icon(Icons.add))
          ],
        ),
      ),
    );
  }
}