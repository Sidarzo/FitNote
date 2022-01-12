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
                  tooltip: 'Enregistrer des machines', 
                  icon: const Icon(Icons.sports_mma),
                  onPressed: () {

                  },
                ),
              ],
            ),
          ),
      );
    }
  }
