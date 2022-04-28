import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setInt('userId', 0);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
