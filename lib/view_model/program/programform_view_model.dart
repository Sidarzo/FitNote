import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/program.dart';

class ProgramFormViewModel extends ChangeNotifier {
  ProgramFormViewModel();

  void createProgramButtonOnClickCommand(String name) async {
    Program program = Program(id: null, name: name);
    Program.insertProgram(program);
  }
}
