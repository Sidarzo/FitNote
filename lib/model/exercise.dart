import 'package:sqflite/sqflite.dart';
import 'db.dart';

 

class Exercise {
  final int? id;
  final String title;
  final String program_id;


  Exercise({
    required this.id,
    required this.title,
    required this.program_id,

  });

  Exercise.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        program_id = res['program_id'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'program_id': program_id,
    };
  }

// Define a function that inserts dogs into the database
  static Future<void> insertExercise(Exercise exercise) async {
    // Get a reference to the database.
    final Database db = await dbFitNote.initializeDB();

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'exercise',
      exercise.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the programs from the program table.
  static Future<List<Exercise>> getExercisesWithProgramId(id) async {
    // Get a reference to the database.
    final Database db = await dbFitNote.initializeDB();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(
      'exercise',
      where: 'program_id = ?',
      whereArgs: [id],
    );

    // Convert the List<Map<String, dynamic> into a List<Program>.
    return List.generate(maps.length, (i) {
      return Exercise(
          id: maps[i]['id'],
          title: maps[i]['title'],
          program_id: maps[i]['program_id'],
          );
    });
  }

  static Future<void> deleteExercise(int id) async {
    // Get a reference to the database.
    final Database db = await dbFitNote.initializeDB();

    // Remove the Dog from the database.
    await db.delete(
      'exercise',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
