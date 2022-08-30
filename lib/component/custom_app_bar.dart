import 'package:fitnote/app_config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:fitnote/app_config/app_config.dart';

class CustomBottomAppBar {
  static BottomAppBar buildAppBar(context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: const Color.fromARGB(255, 32, 32, 32),
       child: Container(
        decoration:  BoxDecoration(
            gradient:  LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.8, 1),
                    colors: <Color>[
                    APP_BAR_COLOR_START,
                    APP_BAR_COLOR_END,
                  ], // Gradient from https://learnui.design/tools/gradient-generator.html
              tileMode: TileMode.clamp,
          ), 
        ),
        child:  IconTheme(
         data: const IconThemeData(color: Colors.black),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
           IconButton(              
               splashRadius: 0.1,
               onPressed: () async {
               Navigator.pushNamed(context, '/programform');
             }, icon: const Icon(Icons.add), iconSize: 35,)
           ],
         ),
       ),
      )
     
    );
  }
}