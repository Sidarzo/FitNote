import 'dart:async';

class Program {
  final int? id;
  final String name;

  Program({
    required this.id,
    required this.name,
  });

  Program.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        name = res['name'];

  Map<String, Object?> toMap() {
    return {'id': id, 'name': name};
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

    List<Program> listProgram = [Program(id: 1, name: 'Programe du lundi soir')];
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
