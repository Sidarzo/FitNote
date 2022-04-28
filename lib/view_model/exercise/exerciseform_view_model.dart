import 'package:fitnote/config/app_settings.dart';
import 'package:flutter/material.dart';
import '../../model/exercise.dart';

class ExerciseFormViewModel extends ChangeNotifier {
  ExerciseFormViewModel();

  void createExerciseButtonOnClickCommand(Exercise exercise) async {
    // var params = {
    //   'title': exercise.title,
    //   'program_id': exercise.program_id.toString(),
    //   'description': '',
    //   'duration': exercise.duration.toString(),
    //   'repetition': exercise.repetition.toString(),
    //   'restDuration': exercise.restDuration.toString(),
    //   'serie': exercise.serie.toString(),
    //   'weight': exercise.weight.toString(),
    //   'type': exercise.type,
    // };
    // await ApiModel.post(AppSettings.API_URL + 'createExercise/', params);
  }
}
