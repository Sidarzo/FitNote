import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class dbtest {
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
                  await database.execute("CREATE TABLE exercice(id INTEGER PRIMARY KEY AUTOINCREMENT,program_id INTEGER, name TEXT NOT NULL,repeat INTEGER NOT NULL,weight INTEGER NOT NULL)");
                }
                if (newVersion == 6) {
                  await database.execute("DROP TABLE exercice");
                  await database.execute("DROP TABLE program");
                  await database.execute("DROP TABLE machine");
                  await database.execute("CREATE TABLE exercice(id INTEGER PRIMARY KEY AUTOINCREMENT,program_id INTEGER, name TEXT NOT NULL,repeat INTEGER NOT NULL,weight INTEGER NOT NULL,machine_id INTEGER NOT NULL)");
                  await database.execute( "CREATE TABLE program(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)");
                  await database.execute( "CREATE TABLE machine(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL,type TEXT NOT NULL)");
                }
                 if (newVersion == 9) {
                  await database.execute('DROP TABLE program');
                  await database.execute("CREATE TABLE exercice(id INTEGER PRIMARY KEY AUTOINCREMENT,program_id INTEGER, name TEXT NOT NULL,repeat INTEGER NOT NULL,weight INTEGER NOT NULL,type_id INTEGER NOT NULL)");
                  await database.execute("CREATE TABLE program(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)");
                  await database.execute("CREATE TABLE exercise_type(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)");
                  await database.execute("INSERT INTO exercise_type VALUES (null, 'Cardio')");
                  await database.execute("INSERT INTO exercise_type VALUES (null, 'Musculation')");


                }
                await batch.commit();
              },
      version: 9,
    );
  }
}