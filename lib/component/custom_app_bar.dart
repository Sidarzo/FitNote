import 'package:flutter/material.dart';

class CustomBottomAppBar{

  static BottomAppBar buildAppBar(context){
      return BottomAppBar(
            shape: CircularNotchedRectangle(),
            color: Colors.blue,
            child: IconTheme(
            data: IconThemeData(color: Colors.white),
            child: Row(
              children: <Widget>[
                IconButton(    
                  tooltip: 'Params', 
                  splashRadius: 0.1,
                  icon: const Icon(Icons.account_box_rounded),
                  onPressed: () {

                  },
                ),
              ],
            ),
          ),
      );
    }
  }
