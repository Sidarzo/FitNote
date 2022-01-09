import 'dart:typed_data';
import 'package:sqflite/sqflite.dart';
import 'dbtest.dart';

class Program {
   final int? id;
   final String name;



  Program(
      {required this.id,
      required this.name,});


  Program.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"];

  Map<String, Object?> toMap() {
    return {'id':id,'name': name};
  }


// Define a function that inserts dogs into the database
 static Future<void> insertProgram(Program program) async {
  // Get a reference to the database.
    final Database db = await dbtest.initializeDB();

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
    final Database db = await dbtest.initializeDB();

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('program');

  // Convert the List<Map<String, dynamic> into a List<Program>.
  return List.generate(maps.length, (i) {
    return Program(
      id: maps[i]['id'],
      name: maps[i]['name'],
    );
  });
}

}