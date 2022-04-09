import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
class DatabaseConnection{
  Future<Database>setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_crud');
    var database =
    await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }
  Future<void>_createDatabase(Database database, int version) async {
    // INTEGER PRIMARY KEY
    String sql=
        "CREATE TABLE mediciness (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,medicineName TEXT,medicineAmount TEXT,medicineType TEXT);";
    await database.execute(sql);
  }
}