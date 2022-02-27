import 'dart:typed_data';
import 'package:sqflite/sqflite.dart';
import 'db.dart';

class Exercise {
  late final int? id;
  final int program_id;
  final String name;
  final int repeat;
  final int weight;
  final int type_id;

  Exercise({
    required this.id,
    required this.program_id,
    required this.name,
    required this.repeat,
    required this.weight,
    required this.type_id,
  });

  Exercise.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        program_id = res["program_id"],
        name = res["name"],
        repeat = res["repeat"],
        weight = res["weight"],
        type_id = res['type_id'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'program_id': program_id,
      'name': name,
      'repeat': repeat,
      'weight': weight,
      'type_id': type_id
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
          program_id: maps[i]['program_id'],
          name: maps[i]['name'],
          repeat: maps[i]['repeat'],
          weight: maps[i]['weight'],
          type_id: maps[i]['type_id']);
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
