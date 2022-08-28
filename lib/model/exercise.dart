import 'package:flutter/cupertino.dart';

class Exercise {
  final int? id;
  final String title;
  // Cardio
  final int? duration;
  final String? description;
  // muscu
  final int? weight;
  final int? repetition;
  final int? serie;
  final int? restDuration;
  //type
  final String type;
  // ignore: non_constant_identifier_names
  final int? program_id;

  late bool isExpanded = false;
  late bool isDone = false;

  Exercise({
    required this.id,
    required this.title,
    // ignore: non_constant_identifier_names
    required this.program_id,
    required this.description,
    required this.duration,
    required this.repetition,
    required this.restDuration,
    required this.serie,
    required this.weight,
    required this.type,
  });




  Exercise.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        program_id = res['program_id'],
        description = res['description'],
        duration = res['duration'],
        repetition = res['repetition'],
        restDuration = res['restDuration'],
        serie = res['serie'],
        weight = res['weight'],
        type = res['type'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'program_id': program_id,
      'description': description,
      'duration': duration,
      'repetition': repetition,
      'restDuration': restDuration,
      'serie': serie,
      'weight': weight,
      'type': type,
    };
  }

  static Future<List<Exercise>> getExercisesWithProgramId(int id) async {
    // final List<dynamic> maps = await ApiModel.get(
    //     AppSettings.API_URL + 'getExercisesWithProgramId/' + id.toString());

    // return List.generate(maps.length, (i) {
    //   return Exercise(
    //     id: maps[i]['id'],
    //     title: maps[i]['title'],
    //     program_id: maps[i]['program_id'],
    //     description: maps[i]['description'],
    //     duration: maps[i]['duration'],
    //     repetition: maps[i]['repetition'],
    //     restDuration: maps[i]['restDuration'],
    //     serie: maps[i]['serie'],
    //     weight: maps[i]['weight'],
    //     type: maps[i]['type'],
    //   );
    // });
    List<Exercise> listExos = [Exercise(id: 1, title: 'Title', program_id: 1, description: 'description', duration: 20, repetition: 4, restDuration: 4, serie: 4, weight: 10, type: 'type')];
    return listExos;
  }

  static buildDescription(Exercise exercise) {
    if (exercise.type == 'Muscu') {
      return Column(
        children: [
          Text('Poids : ' + exercise.weight.toString() + ' kg'),
          Text('Répétitions : ' + exercise.repetition.toString()),
          Text('Séries : ' + exercise.serie.toString()),
          Text('Repos : ' + exercise.restDuration.toString() + ' secs'),
        ],
      );
    } else {
      return Column(
        children: [
          Text('Durée : ' + exercise.duration.toString()),
        ],
      );
    }
  }
}
