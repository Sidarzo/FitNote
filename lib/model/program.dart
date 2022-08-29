import 'dart:async';

class Program {
  final int? id;
  final String name;
  final int duration;
  final int realized;

  Program({
    required this.id,
    required this.name,
    required this.duration,
    required this.realized
  });

  Program.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        name = res['name'],
        duration = res['duration'],
        realized = res['realized'];

  Map<String, Object?> toMap() {
    return {'id': id, 'name': name, 'duration' : duration, 'realized' : realized};
  }

// Define a function that inserts dogs into the database
  static Future<void> insertProgram(int userId, String name) async {
        // await ApiModel.post(
        // AppSettings.API_URL + 'createProgram/' + userId.toString(),
        // {'name': name});
  }

  // A method that retrieves all the programs from the program table.
  static Future<List<Program>> getPrograms() async {
   
    
    // final List<dynamic>? maps = await ApiModel.get(
    //     AppSettings.API_URL + 'getProgramsWithUserId/' + userId.toString());

    // return List.generate(maps?.length ?? 0, (i) {
    //   return Program(
    //     id: maps?[i]['id'],
    //     name: maps?[i]['name'],
    //   );
    // });

    List<Program> listProgram = [
      Program(id: 1, name: 'Programe du lundi soir1', duration: 120, realized : 5),
      Program(id: 2, name: 'Programe du lundi soir2', duration: 120, realized : 6),
      Program(id: 3, name: 'Programe du lundi soir3', duration: 120, realized : 3),
      Program(id: 4, name: 'Programe du lundi soir4', duration: 120, realized : 0),
      Program(id: 5, name: 'Programe du lundi soir5', duration: 120, realized : 1),
      Program(id: 6, name: 'Programe du lundi soir6', duration: 120, realized : 10),
      Program(id: 7, name: 'Programe du lundi soir7', duration: 120, realized : 32),
      Program(id: 8, name: 'Programe du lundi soir8', duration: 120, realized : 4),
      Program(id: 9, name: 'Programe du lundi soir9', duration: 120, realized : 1),
      
      ];
    return listProgram;

  }

  static Future<void> deleteProgram(int id) async {
    // Timer(
    //     const Duration(milliseconds: 10),
    //     () async => await ApiModel.get(
    //         AppSettings.API_URL + 'deleteProgram/' + id.toString()));
  }



  static Future<void> updateProgram(Program program) async {
    // ApiModel.post(
    //     AppSettings.API_URL + 'updateprogram/' + program.id.toString(),
    //     {'name': program.name});
  }
}
