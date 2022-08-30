import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class dbFitNote {
  static initializeDB() async {
    String path = await getDatabasesPath();
   // return deleteDatabase(path);
    return openDatabase(
      join(path, 'fitnote.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE program(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, duration INTEGER NOT NULL, realized INTEGER NOT NULL)",
        );
        await database.execute(
            'CREATE TABLE exercise(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, duration INTEGER, description TEXT, weight INTEGER,repetition INTEGER,serie INTEGER,restDuration INTEGER, type TEXT NOT NULL,program_id INTEGER NOT NULL,FOREIGN KEY(program_id) REFERENCES program(id))');
      },

      onUpgrade: (database, oldVersion, newVersion) async {
        var batch = database.batch();
        if (newVersion == 2) {
          await database.execute(
              "CREATE TABLE exercice(id INTEGER PRIMARY KEY AUTOINCREMENT,program_id INTEGER, name TEXT NOT NULL,repeat INTEGER NOT NULL,weight INTEGER NOT NULL)");
        }
        await batch.commit();
      },
      version: 1,
    );
  }



}



 //           
