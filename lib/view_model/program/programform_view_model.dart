
import 'package:flutter/material.dart';
import '../../model/program.dart';

class ProgramFormViewModel extends ChangeNotifier {
  ProgramFormViewModel();

  void createProgramButtonOnClickCommand(String name) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // int userId = prefs.getInt('userId') ?? 0;
    Program program = Program(id:null, name: name, duration: 120, realized: 4);
     Program.insertProgram(program);

  }
}
