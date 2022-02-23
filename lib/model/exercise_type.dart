import 'dart:typed_data';
import 'package:sqflite/sqflite.dart';
import 'db.dart';

class ExerciseType {
  late final int? id;
  final int name;

  ExerciseType({
    required this.id,
    required this.name,
  });

  ExerciseType.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"];

  Map<String, Object?> toMap() {
    return {'id': id, 'name': name};
  }

  // A method that retrieves all the programs from the program table.
  static Future<List<ExerciseType>> getPrograms() async {
    // Get a reference to the database.
    final Database db = await dbFitNote.initializeDB();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('exercise_type');

    // Convert the List<Map<String, dynamic> into a List<Program>.
    return List.generate(maps.length, (i) {
      return ExerciseType(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }

// Define a function that inserts dogs into the database
  static Future<void> insertExerciseType(ExerciseType exerciseType) async {
    // Get a reference to the database.
    final Database db = await dbFitNote.initializeDB();

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'exercise_type',
      exerciseType.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteExerciseType(int id) async {
    // Get a reference to the database.
    final Database db = await dbFitNote.initializeDB();

    // Remove the Dog from the database.
    await db.delete(
      'exercise_type',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
