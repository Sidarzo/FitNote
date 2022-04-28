import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/program.dart';

class ProgramFormViewModel extends ChangeNotifier {
  ProgramFormViewModel();

  void createProgramButtonOnClickCommand(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId') ?? 0;

    // Program.insertProgram(userId, name);
  }
}
