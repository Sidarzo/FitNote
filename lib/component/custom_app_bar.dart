import 'package:flutter/material.dart';

class CustomBottomAppBar {
  static BottomAppBar buildAppBar(context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: const Color.fromARGB(255, 32, 32, 32),
      child: IconTheme(
        data: const IconThemeData(color: Colors.white),
        child: Row(
          children: <Widget>[
            IconButton(
              tooltip: '',
              splashRadius: 0.1,
              icon: const Icon(Icons.logout),
              onPressed: () async {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
            ),  
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