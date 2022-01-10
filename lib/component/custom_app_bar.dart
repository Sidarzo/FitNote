import 'package:flutter/material.dart';

class CustomBottomAppBar{

  static BottomAppBar buildAppBar(){
    return BottomAppBar(
            shape: CircularNotchedRectangle(),
            color: Colors.blue,
            child: IconTheme(
            data: IconThemeData(color: Colors.white),
            child: Row(
              children: <Widget>[
                IconButton(     
                  icon: const Icon(Icons.crop),
                  onPressed: () {

              },
                ),
              ],
            ),
          ),
      ); 
  }
}