import 'package:sqflite/sqflite.dart';
import 'db.dart';

class Program {
  final int? id;
  final String name;
  final int duration;
  final int realized;

  Program({
    required this.id,
    required this.name,
    required this.duration,
    required this.realized,
  });

  Program.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        name = res['name'],
        duration = res['duration'],
        realized = res['realized'];

  Map<String, Object?> toMap() {
    return {'id': id, 'name': name,'duration' : duration, 'realized' : realized};
  }

// Define a function that inserts dogs into the database
  static Future<void> insertProgram(Program program) async {
    // Get a reference to the database.
    final Database db = await dbFitNote.initializeDB();

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'program',
      program.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the programs from the program table.
  static Future<List<Program>> getPrograms() async {
    // Get a reference to the database.
    final Database db = await dbFitNote.initializeDB();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('program');

    // Convert the List<Map<String, dynamic> into a List<Program>.
    return List.generate(maps.length, (i) {
      return Program(
        id: maps[i]['id'],
        name: maps[i]['name'],
        duration: maps[i]['duration'],
        realized: maps[i]['realized']
      );
    });
  }

  static Future<void> deleteProgram(int id) async {
    // Get a reference to the database.
    final Database db = await dbFitNote.initializeDB();

    // Remove the Dog from the database.
    await db.delete(
      'program',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
