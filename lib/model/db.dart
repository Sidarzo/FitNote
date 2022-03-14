import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class dbFitNote {
  static Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'fitnote.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE program(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)",
        );
      },
      onUpgrade: (database, oldVersion, newVersion) async {
        var batch = database.batch();
        if (newVersion == 4) {
          await database.execute(
              "CREATE TABLE exercice(id INTEGER PRIMARY KEY AUTOINCREMENT,program_id INTEGER, name TEXT NOT NULL,repeat INTEGER NOT NULL,weight INTEGER NOT NULL)");
        }
        if (newVersion == 6) {
          await database.execute("DROP TABLE exercice");
          await database.execute("DROP TABLE program");
          await database.execute("DROP TABLE machine");
          await database.execute(
              "CREATE TABLE exercice(id INTEGER PRIMARY KEY AUTOINCREMENT,program_id INTEGER, name TEXT NOT NULL,repeat INTEGER NOT NULL,weight INTEGER NOT NULL,machine_id INTEGER NOT NULL)");
          await database.execute(
              "CREATE TABLE program(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)");
          await database.execute(
              "CREATE TABLE machine(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL,type TEXT NOT NULL)");
        }
        if (newVersion == 7) {
          await database.execute('DROP TABLE program');
          await database.execute(
              "CREATE TABLE exercice(id INTEGER PRIMARY KEY AUTOINCREMENT,program_id INTEGER, name TEXT NOT NULL,repeat INTEGER NOT NULL,weight INTEGER NOT NULL,type_id INTEGER NOT NULL)");
          await database.execute(
              "CREATE TABLE program(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)");
          await database.execute(
              "CREATE TABLE exercise_type(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)");
          await database
              .execute("INSERT INTO exercise_type VALUES (null, 'Cardio')");
          await database.execute(
              "INSERT INTO exercise_type VALUES (null, 'Musculation')");
        }
        if (newVersion == 18) {
          await database.execute('DROP TABLE program');
          await database.execute(
              'CREATE TABLE program(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)');
          await database.execute(
              'CREATE TABLE exercise(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, program_id INTEGER NOT NULL,FOREIGN KEY(program_id) REFERENCES program(id))');
          await database.execute(
              'CREATE TABLE cardio(id INTEGER PRIMARY KEY AUTOINCREMENT, duration INTEGER NOT NULL, description TEXT NOT NULL,exercise_id INTEGER NOT NULL,FOREIGN KEY(exercise_id) REFERENCES exercise(id))');
          await database.execute(
              'CREATE TABLE muscu(id INTEGER PRIMARY KEY AUTOINCREMENT, weight INTEGER NOT NULL, repetition INTEGER NOT NULL, serie INTEGER NOT NULL, restDuration INTEGER NOT NULL, exercise_id INTEGER NOT NULL,FOREIGN KEY(exercise_id) REFERENCES exercise(id))');
        }
        if (newVersion == 19) {
          await database.execute('DELETE FROM program');
          await database.execute('DELETE FROM exercise');
          await database.execute('ALTER TABLE cardio ADD orderExercice INT');
          await database.execute('ALTER TABLE muscu ADD orderExercice INT');
        }
        if (newVersion == 20) {
          await database.execute(
              'ALTER TABLE cardio RENAME orderExercice TO orderExercise');
          await database.execute(
              'ALTER TABLE muscu RENAME orderExercice TO orderExercise');
        }
        if (newVersion == 21) {
          await database.execute('DELETE FROM program');
          await database.execute('DELETE FROM exercise');
          await database.execute('DELETE FROM cardio');
          await database.execute('DELETE FROM muscu');
        }
        if (newVersion == 23) {
          
          await database.execute('DROP TABLE program');

          await database.execute('DROP TABLE exercise');

          await database.execute(
            "CREATE TABLE program(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)",
          );
          await database.execute(
              'CREATE TABLE exercise(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, duration INTEGER, description TEXT, weight INTEGER,repetition INTEGER,serie INTEGER,restDuration INTEGER, type TEXT NOT NULL,program_id INTEGER NOT NULL,FOREIGN KEY(program_id) REFERENCES program(id))');
        }

        await batch.commit();
      },
      version: 23,
    );
  }
}
