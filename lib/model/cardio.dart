import 'package:sqflite/sqflite.dart';
import 'db.dart';


class Cardio {
  final int? id;
  final int duration;
  final String description;
  final int exercise_id;

  Cardio({
    required this.id,
    required this.duration,
    required this.description,
    required this.exercise_id,
  });

  Cardio.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        duration = res['duration'],
        description = res['description'],
        exercise_id = res['exercise_id'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'duration': duration,
      'description': description,
    };
  }

// Define a function that inserts dogs into the database
  static Future<void> insertExercise(Cardio cardio) async {
    // Get a reference to the database.
    final Database db = await dbFitNote.initializeDB();

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'exercise',
      cardio.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the programs from the program table.
  static Future<List<Cardio>> getExercisesWithProgramId(id) async {
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
      return Cardio(
          id: maps[i]['id'],
          duration: maps[i]['duration'],
          description: maps[i]['description'],
          exercise_id: maps[i]['exercise_id'],
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
