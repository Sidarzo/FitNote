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
    final applicationName = Container(
      color: Colors.purpleAccent,
      padding: const EdgeInsets.all(10),
      child: const Text(
        'FitNote',
        style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
          color: Colors.purple,
        ),
      ),
    );

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 32, 32, 32),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            applicationName,
            const Center(),
          ],
        ));
  }
}
