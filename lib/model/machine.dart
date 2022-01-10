import 'dart:typed_data';
import 'package:sqflite/sqflite.dart';
import 'db_test.dart';

class Machine {
   late final int? id;
   final String name;
   final String type;



  Machine(
      {required this.id,
      required this.name,
      required this.type});


  Machine.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        type = res['type'];

  Map<String, Object?> toMap() {
    return {'id':id,'name': name,'type':type};
  }


// Define a function that inserts dogs into the database
 static Future<void> insertMachine(Machine machine) async {
  // Get a reference to the database.
    final Database db = await dbtest.initializeDB();

  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  await db.insert(
    'machine',
    machine.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

  // A method that retrieves all the machine from the machine table.
static Future<List<Machine>> getMachines() async {
  // Get a reference to the database.
    final Database db = await dbtest.initializeDB();

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('machine');

  // Convert the List<Map<String, dynamic> into a List<Machine>.
  return List.generate(maps.length, (i) {
    return Machine(
      id: maps[i]['id'],
      name: maps[i]['name'],
      type: maps[i]['type'],
    );
  });
}

static Future<void> deleteMachine(int id) async {
  // Get a reference to the database.
    final Database db = await dbtest.initializeDB();

  // Remove the Dog from the database.
  await db.delete(
    'machine',
    // Use a `where` clause to delete a specific dog.
    where: 'id = ?',
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );
}

}