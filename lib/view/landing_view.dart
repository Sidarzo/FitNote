import 'dart:async';
import '/config/app_settings.dart';
import 'package:flutter/material.dart';

class LandingView extends StatefulWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  _LandingViewState createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: AppSettings.SPLASHSCREEN_DURATION),
        routeFirstView);
  }

  void routeFirstView() async {

      Navigator.pushNamedAndRemoveUntil(
          context, '/dashboard', (route) => false);
    
  }

  Widget build(BuildContext context) {
    

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 32, 32, 32),
        body: Container(
          decoration: 
            const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.9, 1),
                  colors: <Color>[
                   Color.fromARGB(255, 191, 250, 236),
                   Color.fromARGB(255, 170, 250, 231),
                   Color.fromARGB(255, 160, 253, 233),
                ], // Gradient from https://learnui.design/tools/gradient-generator.html
            tileMode: TileMode.clamp,
          ),
        ),
      ) 
    );
  }
}
