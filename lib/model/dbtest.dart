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
      version: 1,
    );
  }
}