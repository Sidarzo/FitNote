import 'package:sqflite/sqflite.dart';
import 'db.dart';

 

class Muscu {
  final int? id;
  final double weight;
  final int repetition;
  final int serie;
  final int restDuration;
  final int orderExercise;
  final int exercise_id;




  Muscu({
    required this.id,
    required this.weight,
    required this.repetition,
    required this.serie,
    required this.restDuration,
    required this.orderExercise,
    required this.exercise_id,


  });

  Muscu.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        weight = res['weight'],
        repetition = res['repetition'],
        serie = res['serie'],
        restDuration = res['restDuration'],
        orderExercise = res['orderExercise'],
        exercise_id = res['exercise_id'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'weight': weight,
      'repetition': repetition,
      'serie' : serie,
      'restDuration' : restDuration,
      'orderExercise' : orderExercise,
      'exercise_id' : exercise_id,
    };
  }

// Define a function that inserts dogs into the database
  static Future<void> insertExercise(Muscu muscu) async {
    // Get a reference to the database.
    final Database db = await dbFitNote.initializeDB();

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'exercise',
      muscu.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the programs from the program table.
  static Future<List<Muscu>> getExercisesWithProgramId(id) async {
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
      return Muscu(
          id: maps[i]['id'],
          weight: maps[i]['weight'],
          repetition: maps[i]['repetition'],
          serie: maps[i]['serie'],
          restDuration: maps[i]['restDuration'],
          orderExercise: maps[i]['orderExercise'],
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
