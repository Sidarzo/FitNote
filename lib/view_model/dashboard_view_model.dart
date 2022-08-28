import 'package:flutter/material.dart';
import '../model/program.dart';

class DashboardViewModel extends ChangeNotifier {
  DashboardViewModel();

  Future<List<Program>> getPrograms() {
    return Program.getPrograms();
  }

  void deleteProgram(int id) {
    Program.deleteProgram(id);
  }

  void updateProgram(Program program) {

    // Program.updateProgram(program);
    
  }
}
