import 'dart:typed_data';
import 'package:sqflite/sqflite.dart';
import 'dbtest.dart';

class Exercice {
   late final int? id;
   final int program_id;
   final String name;
   final int repeat;
   final int weight;



  Exercice(
      {required this.id,
      required this.program_id,
      required this.name,
      required this.repeat,
      required this.weight,
      });


  Exercice.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        program_id = res["program_id"],
        name = res["name"],
        repeat = res["repeat"],
        weight = res["weight"];

  Map<String, Object?> toMap() {
    return {'id':id,'program_id': program_id,'name': name,'repeat': repeat,'weight': weight};
  }


// Define a function that inserts dogs into the database
 static Future<void> insertExercice(Exercice exercice) async {
  // Get a reference to the database.
    final Database db = await dbtest.initializeDB();

  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  await db.insert(
    'exercice',
    exercice.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

  // A method that retrieves all the programs from the program table.
static Future<List<Exercice>> getExercices() async {
  // Get a reference to the database.
    final Database db = await dbtest.initializeDB();

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('exercice');

  // Convert the List<Map<String, dynamic> into a List<Program>.
  return List.generate(maps.length, (i) {
    return Exercice(
      id: maps[i]['id'],
      program_id: maps[i]['program_id'],
      name: maps[i]['name'],
      repeat: maps[i]['repeat'],
      weight: maps[i]['weight'],
    );
  });
}

static Future<void> deleteExercice(int id) async {
  // Get a reference to the database.
    final Database db = await dbtest.initializeDB();

  // Remove the Dog from the database.
  await db.delete(
    'exercice',
    // Use a `where` clause to delete a specific dog.
    where: 'id = ?',
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );
}

}